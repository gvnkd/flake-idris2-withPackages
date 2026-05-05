# idris2-mkdoc-md Project Memories

## 2026-05-02: Transitive FFI .so Propagation Fix

### Problem
When `http` package (depends on `tls`) was selected via `withPackages`, the combined `idris2-with-packages` output did not contain `libidristls.so` from the `tls` package. Only directly selected packages had their `.so` files propagated.

### Root Cause
`buildIdris` normalizes library dependencies and uses `lib.withSource` for `propagatedIdrisLibraries`. When we `.overrideAttrs` on a library derivation to add a `postInstall` hook that copies `.so` files, the `passthru.withSource` still pointed to the **unmodified** base library. Downstream packages therefore got the unmodified version without our `.so` copy hook.

### Evidence
- `tls` built directly: drvPath `g4ws...` with `postInstall` hook → had `libidristls.so`
- `tls` via `http.propagatedIdrisLibraries`: drvPath `9phf...` without `postInstall` hook → no `.so`
- Same `pname`, same `src`, same `deps`, but different derivation hashes

### Fix
Use `pkgs.lib.fix` to make `passthru.withSource` self-referential:

```nix
libPkg = pkgs.lib.fix (self:
  (basePkg.library { withSource = true; }).overrideAttrs (old: {
    postInstall = ''
      ${old.postInstall or ""}
      # ... copy .so files ...
    '';
    passthru = old.passthru // {
      withSource = self;
    };
  })
);
```

This ensures `buildIdris` always gets the overridden version when resolving transitive deps.

### Files Changed
- `registry/nix/build-idris-with-docs.nix`
- `flake.nix` (inline `buildIdrisWithDocs`)

### Timeline Bump
Bumped `timeline` from 3 → 4 to force rebuild of all registry packages.

### Verification
```bash
nix build '.#http'
# Then:
nix build --impure --expr '
  let flake = builtins.getFlake "path:/srv/idris2-mkdoc-md";
  in flake.lib.x86_64-linux.withPackages (p: [p.http])
'
find result/lib -name "*.so"
# → result/lib/libbase64-idris.so
# → result/lib/libidristls.so
```
