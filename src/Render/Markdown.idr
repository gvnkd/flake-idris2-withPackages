module Render.Markdown

import Core.Context
import Core.Core
import Idris.Doc.Annotations
import Idris.Pretty.Annotations
import Libraries.Text.PrettyPrint.Prettyprinter.SimpleDocTree

renderMarkdownTree : SimpleDocTree IdrisDocAnn -> Core String
renderMarkdownTree STEmpty = pure ""
renderMarkdownTree (STChar c) = pure (cast c)
renderMarkdownTree (STText _ text) = pure text
renderMarkdownTree (STLine _) = pure "\n"
renderMarkdownTree (STAnn ann rest) =
  case ann of
    Header        => (\s => "**" ++ s ++ "**") <$> renderMarkdownTree rest
    Deprecation   => (\s => "> **Deprecated:** " ++ s) <$> renderMarkdownTree rest
    Declarations  => renderMarkdownTree rest
    Decl _        => renderMarkdownTree rest
    DocStringBody => renderMarkdownTree rest
    UserDocString => (\s => "```\n" ++ s ++ "\n```") <$> renderMarkdownTree rest
    Syntax syn    => case syn of
                         Keyword     => (\s => "`" ++ s ++ "`") <$> renderMarkdownTree rest
                         Fun _       => (\s => "`" ++ s ++ "`") <$> renderMarkdownTree rest
                         TCon _      => (\s => "`" ++ s ++ "`") <$> renderMarkdownTree rest
                         DCon _      => (\s => "`" ++ s ++ "`") <$> renderMarkdownTree rest
                         _           => renderMarkdownTree rest
renderMarkdownTree (STConcat docs) = map fastConcat (traverse renderMarkdownTree docs)

export
renderMarkdown : {auto c : Ref Ctxt Defs} ->
                 SimpleDocTree IdrisDocAnn ->
                 Core String
renderMarkdown tree = renderMarkdownTree tree
