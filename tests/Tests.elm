module Tests where

import ElmTest.Assertion exposing (..)
import ElmTest.Test exposing (..)

import Fifo


all : Test
all =
  suite "all"
    [
      Fifo.empty
      |> Fifo.remove |> fst
      |> assertEqual Nothing
      |> test "empty FIFO contains nothing",

      Fifo.empty
      |> Fifo.isEmpty
      |> assertEqual True
      |> test "empty FIFO is reported as such",

      Fifo.empty
      |> Fifo.insert 7
      |> Fifo.isEmpty
      |> assertEqual False
      |> test "non-empty FIFO is reported as such",

      Fifo.empty
      |> Fifo.insert 7
      |> Fifo.insert 8
      |> Fifo.front
      |> assertEqual (Just 7)
      |> test "can read the front value",

      Fifo.empty
      |> Fifo.insert 9
      |> Fifo.remove |> fst
      |> assertEqual (Just 9)
      |> test "can remove items",

      Fifo.empty
      |> Fifo.insert 9
      |> Fifo.insert 8
      |> Fifo.remove |> fst
      |> assertEqual (Just 9)
      |> test "removes first item first",

      Fifo.empty
      |> Fifo.insert 9
      |> Fifo.insert 8
      |> Fifo.remove |> snd
      |> Fifo.remove |> fst
      |> assertEqual (Just 8)
      |> test "removes second item",

      Fifo.empty
      |> Fifo.insert 9
      |> Fifo.insert 8
      |> Fifo.remove |> snd
      |> Fifo.insert 7
      |> Fifo.remove |> fst
      |> assertEqual (Just 8)
      |> test "can remove an item after removal followed by insertion",

      Fifo.empty
      |> Fifo.insert 9
      |> Fifo.insert 8
      |> Fifo.remove |> snd
      |> Fifo.insert 7
      |> Fifo.remove |> snd
      |> Fifo.remove |> fst
      |> assertEqual (Just 7)
      |> test "can remove an item inserted after a removal",

      Fifo.empty
      |> Fifo.insert 9
      |> Fifo.insert 8
      |> Fifo.remove |> snd
      |> Fifo.insert 7
      |> Fifo.length
      |> assertEqual 2
      |> test "keeping track of length",

      Fifo.empty
      |> Fifo.insert 9
      |> Fifo.insert 8
      |> Fifo.insert 7
      |> Fifo.remove |> snd
      |> Fifo.insert 6
      |> Fifo.insert 5
      |> Fifo.toList
      |> assertEqual [8,7,6,5]
      |> test "toList",

      Fifo.fromList [1,2,3,4]
      |> Fifo.remove |> snd
      |> Fifo.remove |> fst
      |> assertEqual (Just 2)
      |> test "fromList"
    ]
