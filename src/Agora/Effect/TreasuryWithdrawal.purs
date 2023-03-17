-- File auto generated by purescript-bridge! --
module Agora.Effect.TreasuryWithdrawal where

import Prelude

import Aeson (class DecodeAeson, class EncodeAeson)
import Contract.Credential (Credential)
import Contract.PlutusData (class FromData, class ToData)
import Contract.Value (Value)
import Ctl.Extra.FieldOrder (class FieldOrder)
import Ctl.Extra.IsData (productFromData, productToData)
import Data.Generic.Rep (class Generic)
import Data.Lens (Iso')
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Newtype (class Newtype)
import Data.Tuple (Tuple)
import Data.Tuple.Nested (type (/\))
import Prim.RowList (Cons, Nil)

newtype TreasuryWithdrawalDatum = TreasuryWithdrawalDatum
  { receivers :: Array (Credential /\ Value)
  , treasuries :: Array Credential
  }

instance
  FieldOrder TreasuryWithdrawalDatum
    ( Cons "receivers" (Array (Tuple Credential Value))
        (Cons "treasuries" (Array Credential) Nil)
    )

derive instance Generic TreasuryWithdrawalDatum _

derive instance Newtype TreasuryWithdrawalDatum _

instance ToData TreasuryWithdrawalDatum where
  toData = productToData

instance FromData TreasuryWithdrawalDatum where
  fromData = productFromData

derive newtype instance Show TreasuryWithdrawalDatum

derive newtype instance EncodeAeson TreasuryWithdrawalDatum

derive newtype instance DecodeAeson TreasuryWithdrawalDatum

--------------------------------------------------------------------------------

_TreasuryWithdrawalDatum
  :: Iso' TreasuryWithdrawalDatum
       { receivers :: Array (Credential /\ Value)
       , treasuries :: Array Credential
       }
_TreasuryWithdrawalDatum = _Newtype
