{- |

Module: Utils.FieldOrder
Maintainer: nigel@mlabs.city
Description: Helper class for `PlutusData` conversions.

Helper class to be used in conjunction with the `IsData` module
in order to make conversions to and from `PlutusData`.

-}

module Utils.FieldOrder (class FieldOrder) where

import Prim.RowList (RowList)

class FieldOrder (a :: Type) (r :: RowList Type) | a -> r
