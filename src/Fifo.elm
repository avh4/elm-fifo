module Fifo exposing
    ( Fifo, empty, fromList
    , insert, remove
    , toList
    , length
    )

{-|


# Creating FIFOs

@docs Fifo, empty, fromList


# Inserting/Removing

@docs insert, remove


# To List

@docs toList


# Inspecting

@docs length

-}


{-| A FIFO containing items of type `a`.
-}
type Fifo a
    = Fifo (List a) (List a) Int


{-| Creates an empty Fifo.

    Fifo.empty
        -- == Fifo.fromList []

-}
empty : Fifo a
empty =
    Fifo [] [] 0


{-| Inserts an item into a Fifo

    Fifo.empty
    |> Fifo.insert 7
    |> Fifo.insert 8
        -- == Fifo.fromList [7,8]

-}
insert : a -> Fifo a -> Fifo a
insert a (Fifo front back len) =
    Fifo front (a :: back) (len + 1)


{-| Removes the next (oldest) item from a Fifo, returning the item (if any), and the updated Fifo.

    Fifo.fromList [3,7]
    |> Fifo.remove
        -- == (Just 3, Fifo.fromList [7])

-}
remove : Fifo a -> ( Maybe a, Fifo a )
remove fifo =
    case fifo of
        Fifo [] [] _ ->
            ( Nothing, empty )

        Fifo [] back len ->
            remove <| Fifo (List.reverse back) [] len

        Fifo (next :: rest) back len ->
            ( Just next, Fifo rest back (len - 1) )


{-| Creates a Fifo from a List.

    Fifo.fromList [3,4,5]
    |> Fifo.remove
    |> Tuple.first
        -- == Just 3

-}
fromList : List a -> Fifo a
fromList list =
    Fifo list [] (List.length list)


{-| Converts a Fifo to a List.

    Fifo.empty
    |> Fifo.insert 7
    |> Fifo.insert 9
    |> Fifo.toList
        -- == [7,9]

-}
toList : Fifo a -> List a
toList (Fifo front back _) =
    front ++ List.reverse back


{-| Returns the number of items in the Fifo.

    Fifo.fromList [1, 2, 3]
    |> Fifo.remove
    |> Tuple.second
    |> Fifo.length
        -- == 2

-}
length : Fifo a -> Int
length (Fifo _ _ len) =
    len
