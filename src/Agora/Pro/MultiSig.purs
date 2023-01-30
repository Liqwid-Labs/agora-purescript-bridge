module Agora.Pro.MultiSig where

import Prelude

import Data.Newtype (class Newtype)
import Data.Generic.Rep (class Generic)
import Agora.MultiSig (MultiSig)
import Data.Maybe (Maybe)
import Ctl.Internal.TypeLevel.Nat (Z)
import Contract.Value (CurrencySymbol)
import Utils.IsData (productFromData, productToData)
import Utils.FieldOrder (class FieldOrder)
import Prim.RowList (Cons, Nil)
import Contract.PlutusData
  ( class FromData
  , class ToData
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

instance
  FieldOrder MultiSigDatum
    ( Cons "multiSig" (Maybe MultiSig)
        (Cons "atSymbol" (Maybe CurrencySymbol) Nil)
    )

instance ToData MultiSigDatum where
  toData = productToData

instance FromData MultiSigDatum where
  fromData = productFromData

derive instance Generic MultiSigDatum _

derive instance Newtype MultiSigDatum _

derive newtype instance Eq MultiSigDatum

derive newtype instance Show MultiSigDatum
