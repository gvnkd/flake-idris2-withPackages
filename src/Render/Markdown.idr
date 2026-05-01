module Render.Markdown

import Core.Context
import Core.Core
import Data.String
import Idris.Doc.Annotations
import Idris.Pretty.Annotations
import Libraries.Text.PrettyPrint.Prettyprinter.SimpleDocTree

||| Strip leading and trailing whitespace/newlines
strip : String -> String
strip str =
  let chars = unpack str
      trimmed = dropWhile (\c => c == ' ' || c == '\n' || c == '\t') chars
      reversed = dropWhile (\c => c == ' ' || c == '\n' || c == '\t') (reverse trimmed)
   in pack (reverse reversed)
  where
    dropWhile : (Char -> Bool) -> List Char -> List Char
    dropWhile p [] = []
    dropWhile p (x :: xs) = if p x then dropWhile p xs else x :: xs

||| Collapse multiple consecutive blank lines into a single one,
||| and strip leading blank lines.
collapseNewlines : String -> String
collapseNewlines str =
  let ls = lines str
      isBlank : String -> Bool
      isBlank s = all (\c => c == ' ' || c == '\t') (unpack s)
      go : List String -> List String -> List String
      go acc [] = reverse acc
      go acc (x :: xs) =
        if isBlank x
          then case acc of
                 [] => go [] xs
                 (y :: ys) => if isBlank y
                                then go acc xs
                                else go (x :: acc) xs
          else go (x :: acc) xs
   in unlines (go [] ls)

||| Strip leading whitespace from lines that start with markdown formatting
||| (like **bold** or > blockquotes), remove whitespace-only lines,
||| and preserve indentation inside code blocks
fixIndentation : String -> String
fixIndentation str =
  let ls = lines str
      go : Bool -> List String -> List String -> List String
      go _ acc [] = reverse acc
      go inCode acc (x :: xs) =
        let trimmed = ltrim x
            isFence = isPrefixOf "```" trimmed
            newInCode = if isFence then not inCode else inCode
            isBlank = all (\c => c == ' ' || c == '\t') (unpack x)
            fixed = if inCode || isFence
                      then x
                      else if isBlank
                        then ""
                        else if isPrefixOf "**" trimmed || isPrefixOf ">" trimmed
                          then trimmed
                          else x
         in go newInCode (fixed :: acc) xs
   in unlines (go False [] ls)

||| Remove newlines inside Declarations blocks, similar to HTML renderer
removeNewlinesFromDeclarations : SimpleDocTree IdrisDocAnn -> SimpleDocTree IdrisDocAnn
removeNewlinesFromDeclarations = go False
  where
    go : Bool -> SimpleDocTree IdrisDocAnn -> SimpleDocTree IdrisDocAnn
    go False l@(STLine _) = l
    go True l@(STLine _) = STEmpty
    go ignoring (STConcat docs) = STConcat $ map (go ignoring) docs
    go _ (STAnn Declarations rest) = STAnn Declarations (go True rest)
    go _ (STAnn ann rest) = STAnn ann (go False rest)
    go _ doc = doc

||| Strip 2-space indent from docstring lines
stripIndent : String -> String
stripIndent str =
  let ls = lines str
      stripLine : String -> String
      stripLine s = case unpack s of
        ' ' :: ' ' :: cs => pack cs
        cs => pack cs
   in unlines (map stripLine ls)

renderMarkdownTree : Bool -> SimpleDocTree IdrisDocAnn -> Core String
renderMarkdownTree _ STEmpty = pure ""
renderMarkdownTree _ (STChar c) = pure (cast c)
renderMarkdownTree _ (STText _ text) = pure text
renderMarkdownTree _ (STLine _) = pure "\n"

renderMarkdownTree inDecl (STAnn ann rest) =
  case ann of
    Header => do
      h <- renderMarkdownTree inDecl rest
      pure $ "**" ++ h ++ "**"

    Deprecation => do
      d <- renderMarkdownTree inDecl rest
      pure $ "> **Deprecated:** " ++ strip d ++ "\n"

    Declarations => do
      ds <- renderMarkdownTree inDecl rest
      pure $ ds

    Decl _ => do
      sig <- renderMarkdownTree True rest
      pure $ "\n```idris\n" ++ strip sig ++ "\n```\n"

    DocStringBody => do
      body <- renderMarkdownTree inDecl rest
      pure $ strip body ++ "\n"

    UserDocString => do
      doc <- renderMarkdownTree inDecl rest
      pure $ stripIndent doc ++ "\n"
    Syntax syn =>
      if inDecl
      then renderMarkdownTree True rest
      else renderMarkdownTree False rest

renderMarkdownTree inDecl (STConcat docs) =
  fastConcat <$> traverse (renderMarkdownTree inDecl) docs

||| Strip trailing whitespace from each line
trimTrailing : String -> String
trimTrailing str =
  let dropTrailing : List Char -> List Char
      dropTrailing [] = []
      dropTrailing (x :: xs) =
        case dropTrailing xs of
          [] => if x == ' ' || x == '\t' then [] else [x]
          ys => x :: ys
   in pack $ dropTrailing (unpack str)

||| Strip trailing whitespace from all lines, then collapse blanks
cleanMarkdown : String -> String
cleanMarkdown str =
  let ls = lines str
      trimmed = map trimTrailing ls
   in strip (collapseNewlines (unlines trimmed))

export
renderMarkdown : {auto c : Ref Ctxt Defs} ->
                 SimpleDocTree IdrisDocAnn ->
                 Core String
renderMarkdown tree = do
  let cleaned = removeNewlinesFromDeclarations tree
  md <- renderMarkdownTree False cleaned
  pure (strip (fixIndentation (cleanMarkdown md)))
