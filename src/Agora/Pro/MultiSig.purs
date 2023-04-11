module Agora.Pro.MultiSig
  ( MultiSigDatum(..)
  , MultiSigRedeemer(..)
  ) where

import Prelude

import Aeson (class DecodeAeson, class EncodeAeson, decodeAeson, encodeAeson)
import Agora.MultiSig (MultiSig)
import Contract.PlutusData (class FromData, class ToData, PlutusData(..))
import Contract.Prelude (wrap)
import Contract.Value (CurrencySymbol)
import Ctl.Internal.Plutus.Types.DataSchema (class HasPlutusSchema, type (:+), type (:=), type (@@), I, PNil)
import Ctl.Internal.TypeLevel.Nat (Z)
import Data.BigInt as BigInt
import Data.Enum.Generic (genericPred, genericSucc)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Newtype (class Newtype)
import Data.Show.Generic (genericShow)
import Prim.RowList (Cons, Nil)
import Ctl.Extra.FieldOrder (class FieldOrder)
import Ctl.Extra.IsData (productFromData, productToData)
import Data.Enum (class Enum)

newtype MultiSigDatum = MultiSigDatum
  { multiSig :: Maybe MultiSig
  , atSymbol :: Maybe CurrencySymbol
  }

instance
  HasPlutusSchema MultiSigDatum
    ( "MultiSigDatum"
        :=
          ( "multiSig" := I (Maybe MultiSig)
              :+ "atSymbol"
              := I (Maybe CurrencySymbol)
              :+ PNil
          )
        @@ Z
        :+ PNil
    )

instance
  FieldOrder MultiSigDatum
    ( Cons "multiSig" (Maybe MultiSig)
        (Cons "atSymbol" (Maybe CurrencySymbol) Nil)
    )

instance ToData MultiSigDatum where
  toData = productToData

instance FromData MultiSigDatum where
  fromData = productFromData

instance DecodeAeson MultiSigDatum where
  decodeAeson x = wrap <$> decodeAeson x

instance EncodeAeson MultiSigDatum where
  encodeAeson (MultiSigDatum x) = encodeAeson x

derive instance Generic MultiSigDatum _

derive instance Newtype MultiSigDatum _

derive newtype instance Eq MultiSigDatum

derive newtype instance Show MultiSigDatum

data MultiSigRedeemer = MutateMultiSig

instance ToData MultiSigRedeemer where
  toData MutateMultiSig = Integer $ BigInt.fromInt 0

instance FromData MultiSigRedeemer where
  fromData (Integer x) =
    if x == BigInt.fromInt 0 then
      Just MutateMultiSig
    else Nothing
  fromData _ = Nothing

derive instance Generic MultiSigRedeemer _
derive instance Eq MultiSigRedeemer
derive instance Ord MultiSigRedeemer

instance Show MultiSigRedeemer where
  show = genericShow

instance Enum MultiSigRedeemer where
  succ = genericSucc
  pred = genericPred
