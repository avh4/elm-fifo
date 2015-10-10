module Fifo
    ( Fifo
    , empty, insert, remove
    , fromList, toList
    ) where


type Fifo a = Fifo (List a) (List a)


empty : Fifo a
empty =
    Fifo [] []


insert : a -> Fifo a -> Fifo a
insert a (Fifo front back) =
    Fifo front (a::back)


remove : Fifo a -> (Maybe a, Fifo a)
remove fifo =
    case fifo of
        Fifo [] [] ->
            (Nothing, empty)
        Fifo [] back ->
            remove <| Fifo (List.reverse back) []
        Fifo (next::rest) back ->
            (Just next, Fifo rest back)


fromList : List a -> Fifo a
fromList list =
    Fifo list []


toList : Fifo a -> List a
toList (Fifo front back) =
    front ++ List.reverse back
