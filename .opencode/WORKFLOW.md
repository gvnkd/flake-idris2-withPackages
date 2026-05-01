# Implementation Workflow

## 1. Top-Down, Hole-Driven Development

I never implement a function body until its signature compiles. The workflow is:

1. Write the type signature
2. Put `?rhs_name` as the body
3. Compile immediately (`idris2 --build`)
4. Only after successful compilation, look at the hole's suggested type
5. Fill the hole — either directly, or by introducing helper functions with new holes
6. Repeat

## 2. Depth-First Branch Resolution

When a hole requires multiple steps, I work through one logical branch completely before moving to the next:

```idris
-- BAD: all at once
foo : Int -> String
foo n = show (n + 1) ++ "!"

-- GOOD: step by step
foo : Int -> String
foo n = let incremented = ?rhs_incremented
            shown = ?rhs_shown
            suffixed = ?rhs_suffixed
         in suffixed
```

Fill `rhs_incremented`, compile, fill `rhs_shown`, compile, fill `rhs_suffixed`, compile.

## 3. Introduce Sub-Holes, Don't Guess

When a function body needs multiple operations, I decompose it into named sub-holes rather than writing the full implementation:

```idris
-- Instead of writing the whole body, I write:
runMkdoc : Config -> Core ()
runMkdoc config = do
  pkg <- ?rhs_loadPkg
  [] <- ?rhs_prepareCompilation
    | errs => ?rhs_handleErrors
  ?rhs_generateDocs
```

Each sub-hole gets its own type from the compiler. This prevents type mismatches.

## 4. Compile After Every Single Change

I run `idris2 --build` after:
- Adding a new function signature
- Filling any single hole
- Adding a new import
- Changing a type signature

Never batch multiple changes before compiling. The compiler is the source of truth for hole types.

## 5. Functional Style First

When filling holes, I prefer:
- `map`, `traverse`, `for` over explicit recursion
- `foldl` / `foldr` over loops
- `Applicative` combinators (`<*>, <$>`, `pure`) where applicable
- Pipeline style with function composition (`map f . filter p`)

Avoid `for` loops and imperative patterns. If I see one, I refactor it.

## 6. No `do ... let` Notation

Never use:
```idris
do
  let x = expr
  let y = expr2
  ...
```

Use one of:
```idris
let x = expr in do
  ...
```
or
```idris
do
  ...
  where
    x = expr
```

## 7. Module-Level Order

I implement modules in dependency order:
1. Leaf modules first (no internal deps within the project)
2. Modules that depend only on filled leaf modules
3. Up to the top-level `Main`

For this project, the order would be:
1. `CLI` — pure argument parsing, no Core monad
2. `Init` — Core env setup, no project deps
3. `Package` — depends on `Init`
4. `Scanner` — depends on `Package`
5. `Render.Markdown` — depends on `Scanner` (for the annotation types)
6. `Render.Module` — depends on `Render.Markdown`
7. `Render.Index` — depends on nothing (pure function)
8. `Main` — depends on all of the above

## 8. Error Handling

When a compilation fails:
1. Read the error message carefully
2. Fix the most upstream error first (the first one in the output)
3. Often the first fix resolves downstream errors automatically
4. Re-compile immediately after the fix

## 9. What This Means in Practice

For `idris2-mkdoc-md`, the next steps would be:

1. Fill `CLI.rhs_parseArgs` — simple pure function, no Core monad
2. Fill `Init.rhs_initCoreEnv` — requires understanding `Driver.stMain`
3. Fill `Package.rhs_loadPackage` — calls Idris2 API functions
4. Fill `Package.rhs_preparePkgCompilation` — thin wrapper around Idris2 API
5. Fill `Scanner.rhs_getVisibleDefs` — context scanning logic
6. Fill `Render.Markdown.rhs_renderMarkdown` — SimpleDocTree traversal
7. Fill `Render.Module.rhs_renderModuleDoc` — page assembly
8. Fill `Render.Index.rhs_renderDocIndex` — pure index generation
9. Fill `Main.rhs_runMkdoc` — orchestrates the pipeline

Each step: write the implementation, compile, see if new holes appear, repeat.

## 10. Golden Rule

**Never write more than 5-10 lines of implementation before compiling.**
The type checker is the design tool. Use it continuously.
