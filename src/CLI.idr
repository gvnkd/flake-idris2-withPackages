module CLI

public export
record Config where
  constructor MkConfig
  ipkgPath : Maybe String
  outputDir : Maybe String

export
parseArgs : List String -> Config
parseArgs [] = MkConfig Nothing Nothing
parseArgs (_ :: rest) = parseArgs' rest (MkConfig Nothing Nothing)
  where
    parseArgs' : List String -> Config -> Config
    parseArgs' [] acc = acc
    parseArgs' ("-o" :: dir :: xs) acc = parseArgs' xs ({ outputDir := Just dir } acc)
    parseArgs' ("--output" :: dir :: xs) acc = parseArgs' xs ({ outputDir := Just dir } acc)
    parseArgs' (x :: xs) acc = parseArgs' xs ({ ipkgPath := Just x } acc)
