module Agora.Types.AssetClass
  ( AssetClass
  ) where

import Contract.Value (CurrencySymbol, TokenName)

type AssetClass = { symbol :: CurrencySymbol, name :: TokenName }
