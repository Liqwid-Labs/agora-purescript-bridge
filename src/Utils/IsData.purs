{- |

Module: Utils.IsData
Maintainer: nigel@mlabs.city
Description: Helper class for `PlutusData` conversions.

Helper class to be used in conjunction with the `FieldOrder` module
in order to make conversions to and from `PlutusData`.

-}

module Utils.IsData
  ( productToData
  , productFromData
  , class ToDataArgsOrdered
  , toDataArgsOrdered
  , class FromDataArgsOrdered
  , fromDataArgsOrdered
  ) where

import Prelude

import Contract.PlutusData
  ( class FromData
  , class ToData
  , PlutusData
  , fromData
  , toData
  )
import Contract.PlutusData (PlutusData(List)) as PlutusData
import Data.Array as Array
import Data.Maybe (Maybe(Just, Nothing))
import Data.Newtype (class Newtype, unwrap, wrap)
import Data.Symbol (class IsSymbol)
import Prim.Row as R
import Prim.RowList as RL
import Record (get, insert)
import Type.Proxy (Proxy(Proxy))
import Utils.FieldOrder (class FieldOrder)

class ToDataArgsOrdered (list :: RL.RowList Type) (row :: Row Type) where
  toDataArgsOrdered :: Proxy list -> Record row -> Array PlutusData

instance
  ( R.Cons name a nextR row
  , ToData a
  , IsSymbol name
  , ToDataArgsOrdered next row
  ) =>
  ToDataArgsOrdered (RL.Cons name a next) row where
  toDataArgsOrdered _ r =
    Array.cons (toData $ get (Proxy :: Proxy name) r) $ toDataArgsOrdered
      (Proxy :: Proxy next)
      r

instance ToDataArgsOrdered RL.Nil row where
  toDataArgsOrdered _ _ = []

class
  FromDataArgsOrdered (list :: RL.RowList Type) (row :: Row Type)
  | list -> row where
  fromDataArgsOrdered :: Proxy list -> Array PlutusData -> Maybe (Record row)

instance
  ( R.Cons name a nextR row
  , R.Lacks name nextR
  , FromData a
  , IsSymbol name
  , FromDataArgsOrdered next nextR
  ) =>
  FromDataArgsOrdered (RL.Cons name a next) row where
  fromDataArgsOrdered _ xs = do
    { head: h, tail: t } <- Array.uncons xs
    (x :: a) <- fromData h
    tr <- fromDataArgsOrdered (Proxy :: Proxy next) t
    pure $ insert (Proxy :: Proxy name) x tr

instance FromDataArgsOrdered RL.Nil () where
  fromDataArgsOrdered _ [] = Just {}
  fromDataArgsOrdered _ _ = Nothing

productToData
  :: forall a list row
   . Newtype a (Record row)
  => FieldOrder a list
  => ToDataArgsOrdered list row
  => a
  -> PlutusData
productToData x =
  unwrap x
    # toDataArgsOrdered (Proxy :: Proxy list)
    # PlutusData.List

productFromData
  :: forall a row list
   . Newtype a (Record row)
  => FieldOrder a list
  => FromDataArgsOrdered list row
  => PlutusData
  -> Maybe a
productFromData (PlutusData.List xs) = do
  fromDataArgsOrdered (Proxy :: Proxy list) xs <#> wrap
productFromData _ = Nothing
