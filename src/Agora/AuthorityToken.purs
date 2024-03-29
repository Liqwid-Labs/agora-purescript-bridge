-- File auto generated by purescript-bridge! --
module Agora.AuthorityToken where

import Prelude

import Ctl.Extra.AssetClass (AssetClass)
import Data.Generic.Rep (class Generic)
import Data.Lens (Iso')
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Newtype (class Newtype)

newtype AuthorityToken = AuthorityToken { authority :: AssetClass }

derive instance Generic AuthorityToken _

derive instance Newtype AuthorityToken _

derive newtype instance Show AuthorityToken

--------------------------------------------------------------------------------

_AuthorityToken :: Iso' AuthorityToken { authority :: AssetClass }
_AuthorityToken = _Newtype
