module Init

import Compiler.Common
import Core.Context
import Core.Core
import Core.Directory
import Core.InitPrimitives
import Data.List1
import Data.String
import Idris.Package.Types
import Idris.REPL.Opts
import Idris.SetOptions
import Idris.Syntax
import System

export
initPackagePath : {auto c : Ref Ctxt Defs} -> Core ()
initPackagePath = do
  mpath <- coreLift $ getEnv "IDRIS2_PACKAGE_PATH"
  case mpath of
    Nothing => pure ()
    Just path =>
      let paths = forget (Data.String.split (== ':') path)
       in traverse_ addPackageSearchPath paths

export
initCoreEnv : Core ()
initCoreEnv = do
  defs <- initDefs
  c <- newRef Ctxt defs
  s <- newRef Syn initSyntax
  addPrimitives
  setWorkingDir "."
  o <- newRef ROpts (defaultOpts Nothing (REPL InfoLvl) [])
  initPackagePath
  catch (addPkgDir "prelude" anyBounds) (const (pure ()))
  catch (addPkgDir "base" anyBounds) (const (pure ()))
