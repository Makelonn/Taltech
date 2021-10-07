# Notes on haskell

`ghci` to launch a prompt

A prog begin with

    main = do
        putStrLn("This is some content line")

## Type

every expression has a type

Many types are part of different typeclasses

## Type classes

* eq -> equality testing
* ord -> ordering
* show -> types that can be presented as string
* read -> the opposite of show
* bounded -> a lowest and a higher value exist
* enum -> types that can be enumerated

## New types

    data Bool = False | True
        deriving(Eq, Show, Read)