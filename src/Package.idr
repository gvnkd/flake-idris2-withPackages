module Package

import Core.Context
import Core.Core
import Idris.CommandLine
import Idris.Package
import Idris.Package.Types
import Idris.REPL.Opts
import Idris.SetOptions
import Idris.Syntax
import Libraries.Utils.Path

export
loadPackage : {auto c : Ref Ctxt Defs} ->
              {auto s : Ref Syn SyntaxInfo} ->
              {auto o : Ref ROpts REPLOpts} ->
              String -> Core PkgDesc
loadPackage ipkgPath = do
  let Just (dir, filename) = splitParent ipkgPath
      | _ => throw $ InternalError "Tried to split empty string"
  setWorkingDir dir
  pkg <- parsePkgFile True filename
  whenJust (builddir pkg) setBuildDir
  setOutputDir (outputdir pkg)
  pure pkg

export
preparePkgCompilation : {auto c : Ref Ctxt Defs} ->
                        {auto s : Ref Syn SyntaxInfo} ->
                        {auto o : Ref ROpts REPLOpts} ->
                        PkgDesc -> List CLOpt -> Core (List Error)
preparePkgCompilation pkg opts = check pkg opts
