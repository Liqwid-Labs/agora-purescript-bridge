module Agora.Pro.MultiSig where

import Prelude

import Data.Newtype (class Newtype, unwrap, wrap)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Agora.MultiSig (MultiSig)
import Data.Maybe (Maybe(..))
import Ctl.Internal.TypeLevel.Nat (Z)
import Contract.Value (CurrencySymbol)
import Contract.PlutusData
  ( class FromData
  , class ToData
  , genericFromData
  , genericToData
  )
import Ctl.Internal.Plutus.Types.DataSchema
  ( class HasPlutusSchema
  , type (:+)
  , type (:=)
  , type (@@)
  , I
  , PNil
  )

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

instance ToData MultiSigDatum where
  toData = genericToData

instance FromData MultiSigDatum where
  fromData = genericFromData

derive instance Generic MultiSigDatum _

derive instance Newtype MultiSigDatum _

derive newtype instance Eq MultiSigDatum

derive newtype instance Show MultiSigDatum
