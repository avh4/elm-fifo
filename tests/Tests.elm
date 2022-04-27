module Tests exposing (..)

import Expect
import Fifo
import Test exposing (..)


all : Test
all =
    describe "all"
        [ test "empty FIFO contains nothing" <|
            \() ->
                Fifo.empty
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal Nothing
        , test "can remove items" <|
            \() ->
                Fifo.empty
                    |> Fifo.insert 9
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal (Just 9)
        , test "removes first item first" <|
            \() ->
                Fifo.empty
                    |> Fifo.insert 9
                    |> Fifo.insert 8
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal (Just 9)
        , test "removes second item" <|
            \() ->
                Fifo.empty
                    |> Fifo.insert 9
                    |> Fifo.insert 8
                    |> Fifo.remove
                    |> Tuple.second
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal (Just 8)
        , test "removing an item after inserting after a removal" <|
            \() ->
                Fifo.empty
                    |> Fifo.insert 9
                    |> Fifo.insert 8
                    |> Fifo.remove
                    |> Tuple.second
                    |> Fifo.insert 7
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal (Just 8)
        , test "removing an item inserted after a removal" <|
            \() ->
                Fifo.empty
                    |> Fifo.insert 9
                    |> Fifo.insert 8
                    |> Fifo.remove
                    |> Tuple.second
                    |> Fifo.insert 7
                    |> Fifo.remove
                    |> Tuple.second
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal (Just 7)
        , test "toList" <|
            \() ->
                Fifo.empty
                    |> Fifo.insert 9
                    |> Fifo.insert 8
                    |> Fifo.insert 7
                    |> Fifo.remove
                    |> Tuple.second
                    |> Fifo.insert 6
                    |> Fifo.insert 5
                    |> Fifo.toList
                    |> Expect.equal [ 8, 7, 6, 5 ]
        , test "fromList" <|
            \() ->
                Fifo.fromList [ 1, 2, 3, 4 ]
                    |> Fifo.remove
                    |> Tuple.second
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal (Just 2)
        , test "length" <|
            \() ->
                Fifo.fromList [ 1, 2, 3 ]
                    |> Fifo.length
                    |> Expect.equal 3
        , test "length empty" <|
            \() ->
                Fifo.empty
                    |> Fifo.length
                    |> Expect.equal 0
        , test "length insert" <|
            \() ->
                Fifo.empty
                    |> Fifo.insert 42
                    |> Fifo.insert 60
                    |> Fifo.length
                    |> Expect.equal 2
        , test "length remove" <|
            \() ->
                Fifo.fromList [ 1, 2, 3 ]
                    |> Fifo.remove
                    |> Tuple.second
                    |> Fifo.length
                    |> Expect.equal 2
        ]
