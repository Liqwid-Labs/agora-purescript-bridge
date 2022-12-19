-- File auto generated by purescript-bridge! --
module Agora.AuthorityToken where

import Agora.Types.AssetClass (AssetClass)
import Data.Generic.Rep (class Generic)
import Data.Lens (Iso')
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Newtype (class Newtype)

newtype AuthorityToken = AuthorityToken { authority :: AssetClass }

derive instance Generic AuthorityToken _

derive instance Newtype AuthorityToken _

--------------------------------------------------------------------------------

_AuthorityToken :: Iso' AuthorityToken { authority :: AssetClass }
_AuthorityToken = _Newtype
