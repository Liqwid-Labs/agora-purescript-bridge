module ProposalTime where

import Prelude

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
import Ctl.Internal.TypeLevel.Nat (Z)
import Ctl.Internal.Types.Interval (POSIXTime)
import Data.BigInt (BigInt)
import Data.Generic.Rep (class Generic)
import Data.Newtype (class Newtype)

newtype ProposalStartingTime = ProposalStartingTime BigInt

derive instance Newtype ProposalStartingTime _

derive instance Generic ProposalStartingTime _

derive newtype instance Eq ProposalStartingTime

derive newtype instance Show ProposalStartingTime

derive newtype instance ToData ProposalStartingTime

derive newtype instance FromData ProposalStartingTime

--------------------------------------------------------------------------------

newtype ProposalTimingConfig = ProposalTimingConfig
  { draftTime :: POSIXTime
  , votingTime :: POSIXTime
  , lockingTime :: POSIXTime
  , executingTime :: POSIXTime
  , minStakeVotingTime :: POSIXTime
  , votingTimeRangeMaxWidth :: MaxTimeRangeWidth
  }

instance
  HasPlutusSchema ProposalTimingConfig
    ( "ProposalTimingConfig"
        :=
          ( "draftTime" := I POSIXTime
              :+ "votingTime"
              := I POSIXTime
              :+ "lockingTime"
              := I POSIXTime
              :+ "executingTime"
              := I POSIXTime
              :+ "minStakeVotingTime"
              := I POSIXTime
              :+ "votingTimeRangeMaxWidth"
              := I MaxTimeRangeWidth
              :+ PNil
          )
        @@ Z
        :+ PNil
    )

instance ToData ProposalTimingConfig where
  toData = genericToData

instance FromData ProposalTimingConfig where
  fromData = genericFromData

derive instance Eq ProposalTimingConfig

derive instance Newtype ProposalTimingConfig _

derive newtype instance Show ProposalTimingConfig

derive instance Generic ProposalTimingConfig _

--------------------------------------------------------------------------------

newtype MaxTimeRangeWidth = MaxTimeRangeWidth POSIXTime

derive instance Eq MaxTimeRangeWidth

derive instance Ord MaxTimeRangeWidth

derive instance Newtype MaxTimeRangeWidth _

derive instance Generic MaxTimeRangeWidth _

derive newtype instance Show MaxTimeRangeWidth

derive newtype instance ToData MaxTimeRangeWidth

derive newtype instance FromData MaxTimeRangeWidth
