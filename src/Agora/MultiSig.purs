-- File auto generated by purescript-bridge! --
module Agora.MultiSig where

import Ctl.Internal.Types.PubKeyHash (PubKeyHash)
import Data.BigInt (BigInt)
import Data.Generic.Rep (class Generic)
import Data.Lens (Iso')
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Newtype (class Newtype)

newtype MultiSig = MultiSig
  { keys :: Array PubKeyHash
  , minSigs :: BigInt
  }

derive instance Generic MultiSig _

derive instance Newtype MultiSig _

--------------------------------------------------------------------------------

_MultiSig :: Iso' MultiSig { keys :: Array PubKeyHash, minSigs :: BigInt }
_MultiSig = _Newtype
