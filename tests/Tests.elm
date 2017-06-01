module Tests exposing (..)

import Test exposing (..)
import Expect exposing (..)
import Fifo
import Tuple exposing (..)


all : Test
all =
    describe "all"
        [ Fifo.empty
            |> Fifo.remove
            |> first
            |> equal Nothing
            |> (\x -> (\() -> x))
            |> test "empty FIFO contains nothing"
        , Fifo.empty
            |> Fifo.insert 9
            |> Fifo.remove
            |> first
            |> equal (Just 9)
            |> (\x -> (\() -> x))
            |> test "can remove items"
        , Fifo.empty
            |> Fifo.insert 9
            |> Fifo.insert 8
            |> Fifo.remove
            |> first
            |> equal (Just 9)
            |> (\x -> (\() -> x))
            |> test "removes first item first"
        , Fifo.empty
            |> Fifo.insert 9
            |> Fifo.insert 8
            |> Fifo.remove
            |> second
            |> Fifo.remove
            |> first
            |> equal (Just 8)
            |> (\x -> (\() -> x))
            |> test "removes second item"
        , Fifo.empty
            |> Fifo.insert 9
            |> Fifo.insert 8
            |> Fifo.remove
            |> second
            |> Fifo.insert 7
            |> Fifo.remove
            |> first
            |> equal (Just 8)
            |> (\x -> (\() -> x))
            |> test "removing an item after inserting after a removal"
        , Fifo.empty
            |> Fifo.insert 9
            |> Fifo.insert 8
            |> Fifo.remove
            |> second
            |> Fifo.insert 7
            |> Fifo.remove
            |> second
            |> Fifo.remove
            |> first
            |> equal (Just 7)
            |> (\x -> (\() -> x))
            |> test "removing an item inserted after a removal"
        , Fifo.empty
            |> Fifo.insert 9
            |> Fifo.insert 8
            |> Fifo.insert 7
            |> Fifo.remove
            |> second
            |> Fifo.insert 6
            |> Fifo.insert 5
            |> Fifo.toList
            |> equal [ 8, 7, 6, 5 ]
            |> (\x -> (\() -> x))
            |> test "toList"
        , Fifo.fromList [ 1, 2, 3, 4 ]
            |> Fifo.remove
            |> second
            |> Fifo.remove
            |> first
            |> equal (Just 2)
            |> (\x -> (\() -> x))
            |> test "fromList"
        ]
