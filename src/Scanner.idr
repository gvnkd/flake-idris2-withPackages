module Scanner

import Core.Context
import Core.Core
import Core.TT
import Idris.Syntax
import Libraries.Data.WithDefault

visibleDef : GlobalDef -> Bool
visibleDef def = case definition def of
  DCon {} => False
  _ => collapseDefault (visibility def) /= Private

export
getVisibleDefs : {auto c : Ref Ctxt Defs} ->
                 ModuleIdent ->
                 Core (List GlobalDef)
getVisibleDefs mod = do
  defs <- get Ctxt
  let ctxt = gamma defs
  map catMaybes $ for [1 .. nextEntry ctxt - 1] $ \i => do
    mdef <- lookupCtxtExact (Resolved i) ctxt
    case mdef of
      Nothing => pure Nothing
      Just gdef => case isNonEmptyFC (location gdef) of
        Nothing => pure Nothing
        Just nfc => case origin nfc of
          PhysicalIdrSrc mod' =>
            if mod == mod' && visibleDef gdef
               then pure (Just gdef)
               else pure Nothing
          _ => pure Nothing
