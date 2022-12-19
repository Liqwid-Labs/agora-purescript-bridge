-- File auto generated by purescript-bridge! --
module Agora.Stake where

import Prelude

import Agora.Types.AssetClass (AssetClass)
import Agora.Proposal (ProposalId, ResultTag)
import Agora.SafeMoney (GTTag)
import Contract.Credential (Credential)
import Contract.PlutusData
  ( class FromData
  , class ToData
  , genericFromData
  , genericToData
  )
import Contract.Time (POSIXTime)
import Ctl.Internal.Plutus.Types.DataSchema
  ( class HasPlutusSchema
  , type (:+)
  , type (:=)
  , type (@@)
  , PNil
  )
import Ctl.Internal.TypeLevel.Nat (S, Z)
import Data.BigInt (BigInt)
import Data.Generic.Rep (class Generic)
import Data.Lens (Iso', Prism', prism')
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Maybe (Maybe(Just, Nothing))
import Data.Newtype (class Newtype)
import Data.Show.Generic (genericShow)
import Data.Tagged (Tagged)
import Prim.RowList (Cons, Nil)
import Utils.FieldOrder (class FieldOrder)
import Utils.IsData (productFromData, productToData)

newtype Stake = Stake
  { gtClassRef :: Tagged GTTag AssetClass
  , proposalSTClass :: AssetClass
  }

derive instance Generic Stake _

derive instance Newtype Stake _

--------------------------------------------------------------------------------

_Stake
  :: Iso' Stake
       { gtClassRef :: Tagged GTTag AssetClass, proposalSTClass :: AssetClass }
_Stake = _Newtype

--------------------------------------------------------------------------------

newtype ProposalLock = ProposalLock
  { proposalId :: ProposalId
  , action :: ProposalAction
  }

instance
  FieldOrder ProposalLock
    ( Cons "proposalId" ProposalId
        (Cons "action" ProposalAction Nil)
    )

derive instance Generic ProposalLock _

derive instance Newtype ProposalLock _

derive newtype instance Eq ProposalLock

derive newtype instance Show ProposalLock

instance ToData ProposalLock where
  toData = productToData

instance FromData ProposalLock where
  fromData = productFromData

--------------------------------------------------------------------------------

data ProposalAction
  = Created
  | Voted ResultTag POSIXTime
  | Cosigned

derive instance Eq ProposalAction

instance Show ProposalAction where
  show = genericShow

instance
  HasPlutusSchema ProposalAction
    ( "Created" := PNil @@ Z
        :+ "Voted"
        := PNil
        @@ (S Z)
        :+ "Cosigned"
        := PNil
        @@ (S (S Z))
        :+ PNil
    )

derive instance Generic ProposalAction _

instance ToData ProposalAction where
  toData = genericToData

instance FromData ProposalAction where
  fromData = genericFromData

--------------------------------------------------------------------------------

_ProposalLock
  :: Iso' ProposalLock { proposalId :: ProposalId, action :: ProposalAction }
_ProposalLock = _Newtype

--------------------------------------------------------------------------------

data StakeRedeemer
  = DepositWithdraw (Tagged GTTag BigInt)
  | Destroy
  | PermitVote
  | RetractVotes
  | DelegateTo Credential
  | ClearDelegate

derive instance Eq StakeRedeemer

instance Show StakeRedeemer where
  show = genericShow

instance
  HasPlutusSchema StakeRedeemer
    ( "DepositWithdraw" := PNil @@ Z
        :+ "Destroy"
        := PNil
        @@ (S Z)
        :+ "PermitVote"
        := PNil
        @@ (S (S Z))
        :+ "RetractVotes"
        := PNil
        @@ (S (S (S Z)))
        :+ "DelegateTo"
        := PNil
        @@ (S (S (S (S Z))))
        :+ "ClearDelegate"
        := PNil
        @@ (S (S (S (S (S Z)))))
        :+ PNil
    )

derive instance Generic StakeRedeemer _

instance ToData StakeRedeemer where
  toData = genericToData

instance FromData StakeRedeemer where
  fromData = genericFromData

--------------------------------------------------------------------------------

_DepositWithdraw :: Prism' StakeRedeemer (Tagged GTTag BigInt)
_DepositWithdraw = prism' DepositWithdraw case _ of
  (DepositWithdraw a) -> Just a
  _ -> Nothing

_Destroy :: Prism' StakeRedeemer Unit
_Destroy = prism' (const Destroy) case _ of
  Destroy -> Just unit
  _ -> Nothing

_PermitVote :: Prism' StakeRedeemer Unit
_PermitVote = prism' (const PermitVote) case _ of
  PermitVote -> Just unit
  _ -> Nothing

_RetractVotes :: Prism' StakeRedeemer Unit
_RetractVotes = prism' (const RetractVotes) case _ of
  RetractVotes -> Just unit
  _ -> Nothing

_DelegateTo :: Prism' StakeRedeemer Credential
_DelegateTo = prism' DelegateTo case _ of
  DelegateTo a -> Just a
  _ -> Nothing

_ClearDelegate :: Prism' StakeRedeemer Unit
_ClearDelegate = prism' (const ClearDelegate) case _ of
  ClearDelegate -> Just unit
  _ -> Nothing

--------------------------------------------------------------------------------

newtype StakeDatum = StakeDatum
  { stakedAmount :: Tagged GTTag BigInt
  , owner :: Credential
  , delegatedTo :: Maybe Credential
  , lockedBy :: Array ProposalLock
  }

instance
  FieldOrder StakeDatum
    ( Cons "stakedAmount" (Tagged GTTag BigInt)
        ( Cons "owner" Credential
            ( Cons "delegatedTo" (Maybe Credential)
                ( Cons "lockedBy" (Array ProposalLock)
                    Nil
                )
            )
        )
    )

derive instance Generic StakeDatum _

derive instance Newtype StakeDatum _

derive newtype instance Eq StakeDatum

derive newtype instance Show StakeDatum

instance ToData StakeDatum where
  toData = productToData

instance FromData StakeDatum where
  fromData = productFromData

--------------------------------------------------------------------------------

_StakeDatum
  :: Iso' StakeDatum
       { stakedAmount :: Tagged GTTag BigInt
       , owner :: Credential
       , delegatedTo :: Maybe Credential
       , lockedBy :: Array ProposalLock
       }
_StakeDatum = _Newtype
