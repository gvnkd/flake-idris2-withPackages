module Render.Index

import Core.Name.Namespace
import Data.SortedMap
import Idris.Package.Types

export
renderDocIndex : PkgDesc -> SortedMap ModuleIdent String -> String
renderDocIndex pkg modDocs =
  let title = "# " ++ pkg.name ++ "\n\n"
      versionStr = case pkg.version of
        Nothing => ""
        Just v  => "Version: " ++ show v ++ "\n\n"
      desc = case pkg.brief of
        Nothing => ""
        Just b  => b ++ "\n\n"
      modules = "## Modules\n\n"
               ++ concatMap renderModuleLink (modules pkg)
   in title ++ versionStr ++ desc ++ modules
  where
    renderModuleLink : (ModuleIdent, String) -> String
    renderModuleLink (mod, _) =
      let modName = show mod
          modFile = modName ++ ".md"
          doc = case lookup mod modDocs of
                  Nothing => ""
                  Just d  => " - " ++ d
       in "- [" ++ modName ++ "](" ++ modFile ++ ")" ++ doc ++ "\n"
