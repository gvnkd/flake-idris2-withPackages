module Main

import JSON.Simple
import Derive.ToJSON.Simple
import Derive.FromJSON.Simple

record Message where
  constructor MkMessage
  putStrLn : String

%runElab derive "Message" [ToJSON, FromJSON]

main : IO ()
main = putStrLn $ encode $ MkMessage "Hello from Idris2"
