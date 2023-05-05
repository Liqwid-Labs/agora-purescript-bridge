module ProposalTime where

import Prelude

import Contract.PlutusData (class FromData, class ToData)
import Ctl.Extra.FieldOrder (class FieldOrder)
import Ctl.Internal.Types.Interval (POSIXTime)
import Data.Generic.Rep (class Generic)
import Data.Newtype (class Newtype)
import Prim.RowList (Cons, Nil)
import Ctl.Extra.IsData (productFromData, productToData)
import Aeson as Aeson

newtype ProposalStartingTime = ProposalStartingTime POSIXTime

derive instance Newtype ProposalStartingTime _

derive instance Generic ProposalStartingTime _

derive newtype instance Eq ProposalStartingTime

derive newtype instance Show ProposalStartingTime

derive newtype instance ToData ProposalStartingTime

derive newtype instance FromData ProposalStartingTime

derive newtype instance Aeson.EncodeAeson ProposalStartingTime

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
  FieldOrder ProposalTimingConfig
    ( Cons "draftTime" POSIXTime
        ( Cons "votingTime" POSIXTime
            ( Cons "lockingTime" POSIXTime
                ( Cons "executingTime" POSIXTime
                    ( Cons "minStakeVotingTime" POSIXTime
                        ( Cons "votingTimeRangeMaxWidth" MaxTimeRangeWidth Nil
                        )
                    )
                )
            )
        )
    )

instance ToData ProposalTimingConfig where
  toData = productToData

instance FromData ProposalTimingConfig where
  fromData = productFromData

derive instance Eq ProposalTimingConfig

derive instance Newtype ProposalTimingConfig _

derive newtype instance Show ProposalTimingConfig

derive instance Generic ProposalTimingConfig _

derive newtype instance Aeson.EncodeAeson ProposalTimingConfig

--------------------------------------------------------------------------------

newtype MaxTimeRangeWidth = MaxTimeRangeWidth POSIXTime

derive instance Eq MaxTimeRangeWidth

derive instance Ord MaxTimeRangeWidth

derive instance Newtype MaxTimeRangeWidth _

derive instance Generic MaxTimeRangeWidth _

derive newtype instance Show MaxTimeRangeWidth

derive newtype instance ToData MaxTimeRangeWidth

derive newtype instance FromData MaxTimeRangeWidth

derive newtype instance Aeson.EncodeAeson MaxTimeRangeWidth
