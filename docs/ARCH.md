# Architecture: idris2-mkdoc-md

A standalone Markdown documentation generator for Idris2 packages, using Idris2 itself as a library.

---

## 1. Overview

`idris2-mkdoc-md` consumes an `.ipkg` file, typechecks the package, extracts documentation from the compiler's context, and emits structured Markdown instead of HTML.

The tool reuses Idris2's existing documentation extraction pipeline (package loading, context scanning, `getDocsForName`) but replaces the HTML backend with a Markdown renderer.

---

## 2. Architecture Overview

Idris2's built-in doc generator (`--mkdoc`) follows this pipeline:

```
.ipkg --[parsePkgFile]--> PkgDesc
  |
  +--[prepareCompilation]--> typechecked Defs context
  |
  +--[scan context]--> List Name (visible definitions per module)
  |
  +--[getDocsForName]--> Doc IdrisDocAnn (per definition)
  |
  +--[layout + SimpleDocTree]--> SimpleDocTree IdrisDocAnn
  |
  +--[renderHtml]--> String (HTML output)
```

Our tool replicates the left side of this pipeline and replaces the right side:

```
.ipkg --[parsePkgFile]--> PkgDesc
  |
  +--[prepareCompilation]--> typechecked Defs context
  |
  +--[scan context]--> List Name
  |
  +--[getDocsForName]--> Doc IdrisDocAnn
  |
  +--[layout + SimpleDocTree]--> SimpleDocTree IdrisDocAnn
  |
  +--[renderMarkdown]--> String (Markdown output)
```

---

## 3. Key Design Decisions

### 3.1 Standalone Application (not a compiler patch)

We build a separate executable that depends on `idris2` (the API library, `idris2api.ipkg`). This avoids modifying the Idris2 compiler and lets us iterate independently.

Trade-off: `makeDoc` is **not exported** from `Idris.Package`. We must replicate its logic (~100 lines) rather than call it directly.

### 3.2 Reuse `SimpleDocTree` as the rendering boundary

The `SimpleDocTree IdrisDocAnn` intermediate representation is the cleanest boundary for adding a new output format. It is already tree-structured (unlike the flat `SimpleDocStream`), making it natural to render to Markdown.

The type is defined in:
```idris
public export
data SimpleDocTree : Type -> Type where
  STEmpty    : SimpleDocTree ann
  STChar     : (c : Char) -> SimpleDocTree ann
  STText     : (len : Int) -> (text : String) -> SimpleDocTree ann
  STLine     : (i : Int) -> SimpleDocTree ann
  STAnn      : ann -> (rest : SimpleDocTree ann) -> SimpleDocTree ann
  STConcat   : List (SimpleDocTree ann) -> SimpleDocTree ann
```

### 3.3 Target: GitHub-Flavored Markdown

The output should render correctly on GitHub (and similar platforms). This means:
- ATX-style headers (`#`, `##`)
- Fenced code blocks with Idris syntax tags
- Tables for structured data where appropriate
- Relative links between module files

---

## 4. Component Breakdown

### 4.1 Core Monad Initialization (`src/Init.idr`)

Before any Idris2 API function works, we must initialize the `Core` monad environment. This is the hardest part.

Required `Ref`s:
| Ref | Type | Purpose |
|-----|------|---------|
| `Ctxt` | `Ref Ctxt Defs` | Compiler definitions context |
| `Syn` | `Ref Syn SyntaxInfo` | Syntax info, docstrings, operator fixities |
| `ROpts` | `Ref ROpts REPLOpts` | REPL options and output mode |

Minimal initialization sequence (adapted from `stMain` in `Idris.Driver`):

```idris
initCoreEnv : Core ()
initCoreEnv = do
  defs <- initDefs
  c <- newRef Ctxt defs
  s <- newRef Syn initSyntax
  addPrimitives
  setWorkingDir "."
  o <- newRef ROpts (REPL.Opts.defaultOpts Nothing (REPL InfoLvl) [])
  updateEnv  -- CRITICAL: reads IDRIS2_PREFIX, IDRIS2_PATH, etc.
```

`updateEnv` is **mandatory**. Without it, package resolution (`addDeps`) fails because search paths are not populated.

### 4.2 Package Loading (`src/Package.idr`)

Replicate the `makeDoc` entry sequence:

```idris
loadPackage : String -> Core PkgDesc
loadPackage ipkgPath = do
  file <- localPackageFile (Just ipkgPath)
  setWorkingDir (dirname file)
  pkg <- parsePkgFile True file
  whenJust (builddir pkg) setBuildDir
  whenJust (outputdir pkg) setOutputDir
  pure pkg
```

Then call `prepareCompilation pkg opts` to typecheck everything and populate the context.

### 4.3 Context Scanner (`src/Scanner.idr`)

For each module in the package, scan the `Defs` context to find all visible definitions whose `FC.origin` matches that module.

```idris
getVisibleDefs : ModuleIdent -> Core (List GlobalDef)
getVisibleDefs mod = do
  defs <- get Ctxt
  let ctxt = gamma defs
  map catMaybes $ for [1..nextEntry ctxt - 1] $ \i => do
    Just gdef <- lookupCtxtExact (Resolved i) ctxt
      | _ => pure Nothing
    let Just nfc = isNonEmptyFC (location gdef)
      | _ => pure Nothing
    let PhysicalIdrSrc mod' = origin nfc
      | _ => pure Nothing
    let True = mod == mod'
      | _ => pure Nothing
    let True = visible gdef
      | _ => pure Nothing
    pure (Just gdef)
```

### 4.4 Markdown Renderer (`src/Render/Markdown.idr`)

The main work. Pattern match on `SimpleDocTree IdrisDocAnn` and emit Markdown.

Key mappings:

| `IdrisDocAnn` | Markdown output |
|---------------|-----------------|
| `Header` | `## ` prefix |
| `Declarations` | grouped section |
| `Decl n` | `###` header + fenced code block |
| `DocStringBody` | plain paragraph |
| `UserDocString` | indented code block or quoted text |
| `Syntax Keyword` | backticks or just inline |
| `Syntax (Fun n)` | `` `name` `` with link |
| `Syntax (TCon n)` | `` `Name` `` with link |
| `Syntax (DCon n)` | `` `Name` `` with link |
| `Syntax Bound` | plain text |
| `Deprecation` | `> **Deprecated:** ...` blockquote |

`STLine` becomes newline. `STConcat` concatenates children.

Cross-linking strategy: names are resolved to relative paths like `./ModuleName.md#definition-name`.

### 4.5 Module Page Assembly (`src/Render/Module.idr`)

Assembles the full Markdown page for a module:

```idris
renderModuleDoc : ModuleIdent ->
                  Maybe String ->           -- module description
                  Maybe (List (Doc IdrisDocAnn)) -> -- re-exports
                  Maybe (Doc IdrisDocAnn) -> -- definitions
                  Core String
```

Output structure:
```markdown
# Module.Name

[Module description]

## Re-exports

[...]

## Definitions

[...]
```

### 4.6 Index Page (`src/Render/Index.idr`)

Pure function (no `Core`):

```idris
renderDocIndex : PkgDesc -> SortedMap ModuleIdent String -> String
```

Emits a top-level `README.md` or `index.md` with:
- Package name and version
- Description
- Table of modules with links and brief descriptions

---

## 5. File Structure

```
idris2-mkdoc-md/
├── flake.nix                  # Nix dev shell with idris2 + idris2Api
├── idris2-mkdoc-md.ipkg       # Package manifest
├── src/
│   ├── Main.idr               # CLI entry point
│   ├── Init.idr               # Core monad initialization
│   ├── Package.idr            # Package loading wrapper
│   ├── Scanner.idr            # Context scanning
│   ├── Render/
│   │   ├── Markdown.idr       # SimpleDocTree -> Markdown
│   │   ├── Module.idr         # Module page assembly
│   │   └── Index.idr          # Package index page
│   └── CLI.idr                # Argument parsing (optparse style)
├── docs/
│   └── ARCH.md                # This document
└── tests/
    └── ...
```

---

## 6. Implementation Roadmap

### Phase 1: Bootstrap
- [ ] Implement `Init.idr` — minimal Core env setup, verify it works
- [ ] Implement `Package.idr` — load an `.ipkg` and call `prepareCompilation`
- [ ] Test: can we successfully load a simple package and get zero errors?

### Phase 2: Scanning
- [ ] Implement `Scanner.idr` — extract visible names per module
- [ ] Verify the names match what `--mkdoc` would process

### Phase 3: Markdown Renderer (MVP)
- [ ] Implement `Render/Markdown.idr` with basic `SimpleDocTree` traversal
- [ ] Handle `Header`, `Decl`, `DocStringBody`, `Syntax` annotations
- [ ] Render definitions as fenced code blocks
- [ ] No cross-links yet

### Phase 4: Page Assembly
- [ ] Implement `Render/Module.idr`
- [ ] Implement `Render/Index.idr`
- [ ] Write output files to `build/docs/md/` mirror structure

### Phase 5: Polish
- [ ] Add cross-links between modules
- [ ] Handle re-exports
- [ ] CLI argument parsing (output dir, package file path)
- [ ] Error handling and user-friendly messages

### Phase 6: Testing
- [ ] Test against Idris2's own `base` library
- [ ] Compare output coverage with `--mkdoc` HTML output
- [ ] Golden tests for expected Markdown output

---

## 7. Key Types Reference

### `getDocsForName`
```idris
getDocsForName : {auto o : Ref ROpts REPLOpts} ->
                 {auto c : Ref Ctxt Defs} ->
                 {auto s : Ref Syn SyntaxInfo} ->
                 FC -> Name -> Config -> Core (Doc IdrisDocAnn)
```

### `IdrisDocAnn`
```idris
data IdrisDocAnn
  = Header
  | Deprecation
  | Declarations
  | Decl Name
  | DocStringBody
  | UserDocString
  | Syntax IdrisSyntax
```

### `IdrisSyntax` (relevant constructors)
```idris
data IdrisSyntax
  = DCon Name    -- data constructor
  | TCon Name    -- type constructor
  | Fun Name     -- function
  | Keyword
  | Bound
  | ...
```

### `SimpleDocTree`
```idris
data SimpleDocTree : Type -> Type where
  STEmpty  : SimpleDocTree ann
  STChar   : Char -> SimpleDocTree ann
  STText   : Int -> String -> SimpleDocTree ann
  STLine   : Int -> SimpleDocTree ann
  STAnn    : ann -> SimpleDocTree ann -> SimpleDocTree ann
  STConcat : List (SimpleDocTree ann) -> SimpleDocTree ann
```

---

## 8. Risks and Open Questions

1. **API Stability:** `Idris.Package` internals (`makeDoc`, `prepareCompilation`) are not part of the public API. They may change between Idris2 versions. We pin to a specific version via the flake input.

2. **Name Resolution for Links:** The HTML renderer resolves names to file paths using the `Defs` context. We need to replicate this path-mapping logic for Markdown cross-references.

3. **Docstring Formatting:** Idris2 docstrings are plain text with implicit formatting. The HTML renderer wraps them in `<pre>` tags. We may need to preserve line breaks carefully in Markdown.

4. **`makeDoc` replication drift:** If Idris2 adds new doc features (e.g., new annotations), our replicated logic may lag behind. The trade-off of being standalone.

5. **`network` dependency:** `idris2api.ipkg` depends on `network`. The flake already handles this.

---

## 9. Nix Integration

The `flake.nix`:
- Uses `github:idris-lang/Idris2` as a flake input (follows our nixpkgs)
- Exposes `idris2-src.packages.${system}.idris2` (compiler)
- Exposes `idris2-src.packages.${system}.idris2Api` (library)
- Dev shell injects `idris2Api` into `IDRIS2_PACKAGE_PATH`

The `idris2-mkdoc-md.ipkg` declares `depends = idris2`, which resolves to the API library at build time.
