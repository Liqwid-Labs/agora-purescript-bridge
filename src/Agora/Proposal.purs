-- File auto generated by purescript-bridge! --
module Agora.Proposal where

import Prelude

import Aeson (class EncodeAeson, class DecodeAeson)
import Agora.SafeMoney (GTTag)
import Contract.AssocMap (Map(Map))
import Contract.Credential (Credential)
import Contract.PlutusData (class FromData, class ToData, genericFromData, genericToData)
import Contract.Scripts (ScriptHash)
import Ctl.Extra.AssetClass (AssetClass)
import Ctl.Extra.FieldOrder (class FieldOrder)
import Ctl.Extra.IsData (productFromData, productToData)
import Ctl.Extra.Tagged (Tagged)
import Ctl.Internal.Plutus.Types.DataSchema (class HasPlutusSchema, type (:+), type (:=), type (@@), PNil)
import Ctl.Internal.TypeLevel.Nat (S, Z)
import Ctl.Internal.Types.PlutusData (PlutusData(Integer))
import Ctl.Internal.Types.Transaction (DataHash)
import Data.BigInt (BigInt)
import Data.BigInt as BigInt
import Data.Bounded.Generic (genericBottom, genericTop)
import Data.Enum (class Enum)
import Data.Enum.Generic (genericPred, genericSucc)
import Data.Generic.Rep (class Generic)
import Data.Lens (Iso', Prism', prism')
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Maybe (Maybe(..))
import Data.Newtype (class Newtype, unwrap)
import Data.Show.Generic (genericShow)
import Data.Tuple (Tuple)
import Data.Tuple.Nested ((/\))
import Prim.RowList (Cons, Nil)
import ProposalTime (ProposalStartingTime, ProposalTimingConfig)

newtype ProposalId = ProposalId BigInt

derive instance Generic ProposalId _

derive instance Newtype ProposalId _

derive newtype instance Eq ProposalId

derive newtype instance Show ProposalId

derive newtype instance ToData ProposalId

derive newtype instance FromData ProposalId

--------------------------------------------------------------------------------

newtype ResultTag = ResultTag BigInt

derive instance Generic ResultTag _

derive instance Newtype ResultTag _

derive instance Eq ResultTag

derive instance Ord ResultTag

derive newtype instance Show ResultTag

derive newtype instance ToData ResultTag

derive newtype instance FromData ResultTag

derive newtype instance EncodeAeson ResultTag

derive newtype instance DecodeAeson ResultTag

--------------------------------------------------------------------------------

_ResultTag :: Iso' ResultTag BigInt
_ResultTag = _Newtype

--------------------------------------------------------------------------------

data ProposalStatus
  = Draft
  | VotingReady
  | Locked
  | Finished

instance ToData ProposalStatus where
  toData Draft = Integer $ BigInt.fromInt 0
  toData VotingReady = Integer $ BigInt.fromInt 1
  toData Locked = Integer $ BigInt.fromInt 2
  toData Finished = Integer $ BigInt.fromInt 3

instance FromData ProposalStatus where
  fromData :: PlutusData -> Maybe ProposalStatus
  fromData x = case x of
    (Integer y) ->
      if y == BigInt.fromInt 0 then Just Draft
      else if y == BigInt.fromInt 1 then Just VotingReady
      else if y == BigInt.fromInt 2 then Just Locked
      else if y == BigInt.fromInt 3 then Just Finished
      else Nothing
    _ -> Nothing

instance Show ProposalStatus where
  show Draft = "Draft"
  show VotingReady = "VotingReady"
  show Locked = "Locked"
  show Finished = "Finished"

derive instance Eq ProposalStatus

derive instance Ord ProposalStatus

derive instance Generic ProposalStatus _

instance Enum ProposalStatus where
  succ = genericSucc
  pred = genericPred

instance Bounded ProposalStatus where
  bottom = genericBottom
  top = genericTop

--------------------------------------------------------------------------------

_Draft :: Prism' ProposalStatus Unit
_Draft = prism' (const Draft) case _ of
  Draft -> Just unit
  _ -> Nothing

_VotingReady :: Prism' ProposalStatus Unit
_VotingReady = prism' (const VotingReady) case _ of
  VotingReady -> Just unit
  _ -> Nothing

_Locked :: Prism' ProposalStatus Unit
_Locked = prism' (const Locked) case _ of
  Locked -> Just unit
  _ -> Nothing

_Finished :: Prism' ProposalStatus Unit
_Finished = prism' (const Finished) case _ of
  Finished -> Just unit
  _ -> Nothing

--------------------------------------------------------------------------------

newtype ProposalThresholds = ProposalThresholds
  { execute :: Tagged GTTag BigInt
  , create :: Tagged GTTag BigInt
  , toVoting :: Tagged GTTag BigInt
  , vote :: Tagged GTTag BigInt
  , cosign :: Tagged GTTag BigInt
  }

instance
  FieldOrder ProposalThresholds
    ( Cons "execute" (Tagged GTTag BigInt)
        ( Cons "create" (Tagged GTTag BigInt)
            ( Cons "toVoting" (Tagged GTTag BigInt)
                ( Cons "vote" (Tagged GTTag BigInt)
                    ( Cons "cosign" (Tagged GTTag BigInt) Nil
                    )
                )
            )
        )
    )

instance ToData ProposalThresholds where
  toData = productToData

instance FromData ProposalThresholds where
  fromData = productFromData

derive instance Generic ProposalThresholds _

derive instance Newtype ProposalThresholds _

derive newtype instance Show ProposalThresholds

derive newtype instance Eq ProposalThresholds

--------------------------------------------------------------------------------

_ProposalThresholds
  :: Iso' ProposalThresholds
       { execute :: Tagged GTTag BigInt
       , create :: Tagged GTTag BigInt
       , toVoting :: Tagged GTTag BigInt
       , vote :: Tagged GTTag BigInt
       , cosign :: Tagged GTTag BigInt
       }
_ProposalThresholds = _Newtype

--------------------------------------------------------------------------------

newtype ProposalVotes = ProposalVotes (Map ResultTag BigInt)

instance
  HasPlutusSchema ProposalVotes
    ( "ProposalVotes" := PNil @@ Z
        :+ PNil
    )

derive instance Generic ProposalVotes _

derive instance Newtype ProposalVotes _

derive newtype instance Show ProposalVotes

derive newtype instance Eq ProposalVotes

derive newtype instance ToData ProposalVotes

derive newtype instance FromData ProposalVotes

--------------------------------------------------------------------------------

_ProposalVotes
  :: Iso' ProposalVotes (Map ResultTag BigInt)
_ProposalVotes = _Newtype

--------------------------------------------------------------------------------

newtype ProposalEffectMetadata = ProposalEffectMetadata
  { datumHash :: DataHash
  , scriptHash :: Maybe ScriptHash
  }

instance
  FieldOrder ProposalEffectMetadata
    ( Cons "datumHash" DataHash
        (Cons "scriptHash" (Maybe ScriptHash) Nil)
    )

derive instance Generic ProposalEffectMetadata _

derive instance Newtype ProposalEffectMetadata _

derive newtype instance Show ProposalEffectMetadata

derive newtype instance Eq ProposalEffectMetadata

instance ToData ProposalEffectMetadata where
  toData = productToData

instance FromData ProposalEffectMetadata where
  fromData = productFromData

_ProposalEffectMetadata
  :: Iso' ProposalEffectMetadata
       { datumHash :: DataHash, scriptHash :: Maybe ScriptHash }
_ProposalEffectMetadata = _Newtype

--------------------------------------------------------------------------------

type ProposalEffectGroup = Map ScriptHash ProposalEffectMetadata

--------------------------------------------------------------------------------

newtype ProposalDatum = ProposalDatum
  { proposalId :: ProposalId
  , effects :: Map ResultTag ProposalEffectGroup
  , status :: ProposalStatus
  , cosigners :: Array Credential
  , thresholds :: ProposalThresholds
  , votes :: ProposalVotes
  , timingConfig :: ProposalTimingConfig
  , startingTime :: ProposalStartingTime
  }

instance
  FieldOrder ProposalDatum
    ( Cons "proposalId" ProposalId
        ( Cons "effects"
            (Map ResultTag ProposalEffectGroup)
            ( Cons "status" ProposalStatus
                ( Cons "cosigners" (Array Credential)
                    ( Cons "thresholds" ProposalThresholds
                        ( Cons "votes" ProposalVotes
                            ( Cons "timingConfig" ProposalTimingConfig
                                (Cons "startingTime" ProposalStartingTime Nil)
                            )
                        )
                    )
                )
            )
        )
    )

derive instance Generic ProposalDatum _

derive instance Newtype ProposalDatum _

derive newtype instance Show ProposalDatum

derive newtype instance Eq ProposalDatum

instance ToData ProposalDatum where
  toData = productToData

instance FromData ProposalDatum where
  fromData = productFromData

--------------------------------------------------------------------------------

_ProposalDatum
  :: Iso' ProposalDatum
       { proposalId :: ProposalId
       , effects ::
           Map ResultTag ProposalEffectGroup
       , status :: ProposalStatus
       , cosigners :: Array Credential
       , thresholds :: ProposalThresholds
       , votes :: ProposalVotes
       , timingConfig :: ProposalTimingConfig
       , startingTime :: ProposalStartingTime
       }
_ProposalDatum = _Newtype

--------------------------------------------------------------------------------

-- | Same as ProposalDatum type but replacing the Map types
-- | for 'effects' and 'votes' with an Array of Tuples.
-- | We do this in order to avoid issues
-- | when working with JavaScript via the API.
newtype ProposalDatumJS = ProposalDatumJS
  { proposalId :: ProposalId
  , effects ::
      Array
        (Tuple ResultTag (Array (Tuple ScriptHash ProposalEffectMetadata)))
  , status :: ProposalStatus
  , cosigners :: Array Credential
  , thresholds :: ProposalThresholds
  , votes :: Array (Tuple ResultTag BigInt)
  , timingConfig :: ProposalTimingConfig
  , startingTime :: ProposalStartingTime
  }

derive instance Newtype ProposalDatumJS _

derive newtype instance Show ProposalDatumJS

derive newtype instance Eq ProposalDatumJS

-- | Conversion function for working with JS.
proposalDatumToProposalDatumJS
  :: ProposalDatum
  -> ProposalDatumJS
proposalDatumToProposalDatumJS (ProposalDatum p) =
  ProposalDatumJS p
    { effects = convertEffects p.effects
    , votes = let Map ys = (unwrap p.votes) in ys
    }

convertEffects
  :: Map ResultTag ProposalEffectGroup
  -> Array (Tuple ResultTag (Array (Tuple ScriptHash ProposalEffectMetadata)))
convertEffects map' =
  let
    Map xs = map'
    zs = (\(r /\ Map ys) -> r /\ ys) <$> xs
  in
    zs

--------------------------------------------------------------------------------

data ProposalRedeemer
  = Vote ResultTag
  | Cosign
  | UnlockStake
  | AdvanceProposal

instance
  HasPlutusSchema ProposalRedeemer
    ( "Vote" := PNil @@ Z
        :+ "Cosign"
        := PNil
        @@ (S Z)
        :+ "UnlockStake"
        := PNil
        @@ (S (S Z))
        :+ "AdvanceProposal"
        := PNil
        @@ (S (S (S Z)))
        :+ PNil
    )

derive instance Generic ProposalRedeemer _

derive instance Eq ProposalRedeemer

instance Show ProposalRedeemer where
  show = genericShow

instance ToData ProposalRedeemer where
  toData :: ProposalRedeemer -> PlutusData
  toData = genericToData

instance FromData ProposalRedeemer where
  fromData :: PlutusData -> Maybe ProposalRedeemer
  fromData = genericFromData

--------------------------------------------------------------------------------

_Vote :: Prism' ProposalRedeemer ResultTag
_Vote = prism' Vote case _ of
  Vote a -> Just a
  _ -> Nothing

_Cosign :: Prism' ProposalRedeemer Unit
_Cosign = prism' (\_ -> Cosign) f
  where
  f Cosign = Just unit
  f _ = Nothing

_UnlockStake :: Prism' ProposalRedeemer Unit
_UnlockStake = prism' (const UnlockStake) case _ of
  UnlockStake -> Just unit
  _ -> Nothing

_AdvanceProposal :: Prism' ProposalRedeemer Unit
_AdvanceProposal = prism' (const AdvanceProposal) case _ of
  AdvanceProposal -> Just unit
  _ -> Nothing

--------------------------------------------------------------------------------

newtype Proposal = Proposal
  { governorSTAssetClass :: AssetClass
  , stakeSTAssetClass :: AssetClass
  , maximumCosigners :: BigInt
  }

derive instance Generic Proposal _

derive instance Newtype Proposal _

derive newtype instance Show Proposal

--------------------------------------------------------------------------------

_Proposal
  :: Iso' Proposal
       { governorSTAssetClass :: AssetClass
       , stakeSTAssetClass :: AssetClass
       , maximumCosigners :: BigInt
       }
_Proposal = _Newtype
