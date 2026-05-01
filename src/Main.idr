module Main

import Compiler.Common
import Core.Context
import Core.Core
import Core.Directory
import Core.InitPrimitives
import Idris.CommandLine
import Data.SortedMap
import Core.UnifyState
import Idris.Doc.String
import Idris.Package.Types
import Idris.Pretty
import Idris.ProcessIdr
import Idris.REPL.Opts
import Idris.SetOptions
import Idris.Syntax
import Libraries.Utils.Path
import System
import System.File

import Init
import Package
import Scanner
import Render.Markdown
import Render.Module
import Render.Index
import CLI

processModuleAndWrite : {auto c : Ref Ctxt Defs} ->
                        {auto s : Ref Syn SyntaxInfo} ->
                        {auto o : Ref ROpts REPLOpts} ->
                        PkgDesc -> String -> (ModuleIdent, String) -> Core ()
processModuleAndWrite pkg docDir (mod, filename) = do
  u <- newRef UST initUState
  setPPrint docsPPrint
  let ns = miAsNamespace mod
  addImport (MkImport emptyFC False mod ns)

  visibleDefs <- getVisibleDefs mod
  allDocs <- traverse (\def => getDocsForName emptyFC (fullname def) shortNamesConfig)
                     (sortBy (compare `on` startPos . toNonEmptyFC . location) visibleDefs)
  let allDecls = annotate Declarations $ vcat allDocs

  syn <- get Syn
  let modDoc = lookup mod (modDocstrings syn)
  let mreexports = do docs <- lookup mod $ modDocexports syn
                      guard (not $ null docs)
                      pure docs
  let modExports = map (map (reAnnotate Syntax . prettyImport)) mreexports

  let outputFilePath = docDir </> (show mod ++ ".md")
  doc <- renderModuleDoc mod modDoc modExports
                 (allDecls <$ guard (not $ null allDocs))
  Right () <- coreLift $ writeFile outputFilePath doc
    | Left err => throw $ InternalError ("Cannot write module doc: " ++ show err)

  pure ()

runMkdoc : CLI.Config -> Core ()
runMkdoc config = do
  defs <- initDefs
  c <- newRef Ctxt defs
  s <- newRef Syn initSyntax
  addPrimitives
  setWorkingDir "."
  o <- newRef ROpts (defaultOpts Nothing (REPL InfoLvl) [])
  initPackagePath
  catch (addPkgDir "prelude" anyBounds) (const (pure ()))
  catch (addPkgDir "base" anyBounds) (const (pure ()))

  let Just ipkgPath = config.ipkgPath
      | Nothing => throw $ UserError "No .ipkg file specified."
  pkg <- loadPackage ipkgPath
  [] <- preparePkgCompilation pkg []
    | errs => throw $ UserError "Compilation errors occurred."
  let outDir = fromMaybe "build/docs/md" config.outputDir
  Right () <- coreLift $ mkdirAll outDir
    | Left err => throw $ InternalError ("Cannot create output directory: " ++ show err)

  let docDir = outDir </> "docs"
  Right () <- coreLift $ mkdirAll docDir
    | Left err => throw $ InternalError ("Cannot create docs directory: " ++ show err)

  traverse_ (processModuleAndWrite pkg docDir) (modules pkg)

  syn <- get Syn
  let index = renderDocIndex pkg (modDocstrings syn)
  Right () <- coreLift $ writeFile (outDir </> "index.md") index
    | Left err => throw $ InternalError ("Cannot write index: " ++ show err)

  pure ()

main : IO ()
main = do
  args <- getArgs
  let config = parseArgs args
  coreRun (runMkdoc config)
    (\err => putStrLn ("Error: " ++ show err))
    (\_  => putStrLn "Documentation generated successfully.")
