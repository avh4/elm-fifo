module Fifo (Fifo, empty, isEmpty, insert, remove, front, length, fromList, toList) where

{-|

# Creating FIFOs
@docs Fifo, empty, fromList

# Inserting/Removing
@docs insert, remove

# To List
@docs toList

# Checking state
@docs isEmpty, front, length

-}


{-| A FIFO containing items of type `a`.
-}
type Fifo a
    = Empty | Node a (List a)

{-| Creates an empty Fifo.

    Fifo.empty
        -- == Fifo.fromList []

-}
empty : Fifo a
empty =
    Empty


{-| Checks whether a Fifo is empty.

    Fifo.empty
    |> Fifo.insert 7
    |> Fifo.isEmpty
        -- == False
-}
isEmpty : Fifo a -> Bool
isEmpty fifo =
    fifo == Empty

{-| Inserts an item into a Fifo

    Fifo.empty
    |> Fifo.insert 7
    |> Fifo.insert 8
        -- == Fifo.fromList [7,8]

-}
insert : a -> Fifo a -> Fifo a
insert a fifo =
    case fifo of
        Empty ->
            Node a []

        Node front back ->
            Node front (List.append back [a])


{-| Removes the next (oldest) item from a Fifo, returning the item (if any), and the updated Fifo.

    Fifo.fromList [3,7]
    |> Fifo.remove
        -- == (Just 3, Fifo.fromList [7])

-}
remove : Fifo a -> ( Maybe a, Fifo a )
remove fifo =
    case fifo of
        Empty ->
            ( Nothing, empty )

        Node front [] ->
            ( Just front, empty )

        Node front (next :: rest) ->
            ( Just front, Node next rest )


{-| Reads a Fifo's front value.

    Fifo.fromList [3,7]
    |> Fifo.front
        -- == (Just 3)

-}
front : Fifo a -> Maybe a
front fifo =
    case fifo of
        Empty ->
            Nothing

        Node front back ->
            Just front


{-| Reports the length of a Fifo.

    Fifo.fromList [3,4,5]
    |> Fifo.length
        -- == 3

-}
length : Fifo a -> Int
length fifo =
    case fifo of
        Empty ->
            0
        Node front back ->
            1 + List.length back


{-| Creates a Fifo from a List.

    Fifo.fromList [3,4,5]
    |> Fifo.remove
    |> fst
        -- == Just 3

-}
fromList : List a -> Fifo a
fromList list =
    case list of
        (first :: rest) ->
            Node first rest

        [] ->
            empty


{-| Converts a Fifo to a List.

    Fifo.empty
    |> Fifo.insert 7
    |> Fifo.insert 9
    |> Fifo.toList
        -- == [7,9]
-}
toList : Fifo a -> List a
toList fifo =
    case fifo of
        Empty ->
            []

        Node front back ->
            [front] ++ back
