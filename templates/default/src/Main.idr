module Main

import JSON
import JSON.Derive

%language ElabReflection

record Message where
  constructor MkMessage
  text : String

%runElab derive "Message" [ToJSON, FromJSON]

main : IO ()
main = putStrLn $ encode $ MkMessage "Hello from Idris2"
