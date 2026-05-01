module Render.Module

import Core.Context
import Core.Core
import Data.String
import Idris.Doc.Annotations
import Idris.Package.Types
import Libraries.Text.PrettyPrint.Prettyprinter.Doc
import Libraries.Text.PrettyPrint.Prettyprinter.SimpleDocTree
import Render.Markdown

docToMarkdown : {auto c : Ref Ctxt Defs} -> Doc IdrisDocAnn -> Core String
docToMarkdown doc =
  let stream = layoutUnbounded doc
      tree = SimpleDocTree.fromStream stream
   in renderMarkdown tree

joinSections : List String -> String
joinSections = fastConcat . intersperse "\n\n" . filter (/= "")

export
renderModuleDoc : {auto c : Ref Ctxt Defs} ->
                  ModuleIdent ->
                  Maybe String ->
                  Maybe (List (Doc IdrisDocAnn)) ->
                  Maybe (Doc IdrisDocAnn) ->
                  Core String
renderModuleDoc mod modDoc mreexports mdefs = do
  let header = "# " ++ show mod
  desc <- case modDoc of
    Nothing => pure ""
    Just d  => pure d
  reexports <- case mreexports of
    Nothing => pure ""
    Just docs => do
      md <- traverse docToMarkdown docs
      let items = map ("- " ++) md
      pure ("## Re-exports\n\n" ++ unlines items)
  defs <- case mdefs of
    Nothing => pure ""
    Just doc => do
      md <- docToMarkdown doc
      pure ("## Definitions\n\n" ++ md)
  pure (joinSections [header, desc, reexports, defs])
