module Tests exposing (..)

import Test exposing (..)
import Expect
import Fifo


suite : Test
suite =
    describe "Fifo"
        [ test "empty FIFO contains nothing" <|
            \_ ->
                Fifo.empty
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal Nothing
        , test "can remove items" <|
            \_ ->
                Fifo.empty
                    |> Fifo.insert 9
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal (Just 9)
        , test "removes first item first" <|
            \_ ->
                Fifo.empty
                    |> Fifo.insert 9
                    |> Fifo.insert 8
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal (Just 9)
        , test "removes second item" <|
            \_ ->
                Fifo.empty
                    |> Fifo.insert 9
                    |> Fifo.insert 8
                    |> Fifo.remove
                    |> Tuple.second
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal (Just 8)
        , test "removing an item after inserting after a removal" <|
            \_ ->
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
            \_ ->
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
            \_ ->
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
            \_ ->
                Fifo.fromList [ 1, 2, 3, 4 ]
                    |> Fifo.remove
                    |> Tuple.second
                    |> Fifo.remove
                    |> Tuple.first
                    |> Expect.equal (Just 2)
        ]
