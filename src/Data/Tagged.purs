module Data.Tagged (Tagged(..), tag) where

import Contract.Prelude

import Contract.PlutusData
  ( class FromData
  , class ToData
  , PlutusData(Integer)
  , toData
  )
import Ctl.Internal.Plutus.Types.DataSchema
  ( class HasPlutusSchema
  , type (:+)
  , type (:=)
  , type (@@)
  , I
  , PNil
  )
import Ctl.Internal.TypeLevel.Nat (Z)
import Data.BigInt (BigInt)
import Data.Generic.Rep (class Generic)
import Data.Newtype (class Newtype)
import Aeson
  ( class DecodeAeson
  , class EncodeAeson
  , decodeAeson
  , encodeAeson'
  )

tag :: forall s a. a -> Tagged s a
tag x = Tagged x

newtype Tagged :: forall k. k -> Type -> Type
newtype Tagged s b = Tagged b

derive instance Newtype (Tagged s b) _

derive instance Generic (Tagged s b) _

instance
  HasPlutusSchema (Tagged s b)
    ( "Tagged"
        :=
          ( "Tagged" := I b
              :+ PNil
          )
        @@ Z
        :+ PNil
    )

instance ToData b => ToData (Tagged a b) where
  toData (Tagged x) = toData x

instance FromData (Tagged a BigInt) where
  fromData (Integer x) = Just (Tagged x)
  fromData _ = Nothing

instance Show b => Show (Tagged s b) where
  show (Tagged x) = show x

instance (Eq a, Eq b) => Eq (Tagged a b) where
  eq (Tagged x) (Tagged y) = eq x y

instance (Ord a, Ord b) => Ord (Tagged a b) where
  compare (Tagged x) (Tagged y) = compare x y

instance EncodeAeson a => EncodeAeson (Tagged tag a) where
  encodeAeson' (Tagged x) = encodeAeson' x

instance DecodeAeson a => DecodeAeson (Tagged tag a) where
  decodeAeson x = Tagged <$> decodeAeson x