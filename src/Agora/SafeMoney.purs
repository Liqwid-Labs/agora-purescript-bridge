module Agora.SafeMoney
  ( ADATag(..)
  , AuthorityTokenTag(..)
  , GTTag(..)
  ) where

import Prelude

import Contract.PlutusData (class FromData, class ToData)
import Ctl.Internal.Types.PlutusData (PlutusData(Constr))
import Ctl.Internal.Types.BigNum (zero) as BigNum
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(Nothing))

-- NOTE: added data constructor because of a warning
-- basically it complains that you can create a value of the type with `fromData`
data GTTag = GTTag

derive instance Eq GTTag

derive instance Ord GTTag

derive instance Generic GTTag _

instance ToData GTTag where
  toData _ = Constr BigNum.zero []

instance FromData GTTag where
  fromData _ = Nothing

data ADATag

data AuthorityTokenTag