{ name = "agora-purescript-bridge"
, dependencies =
  [ "uint"
  , "aeson"
  , "bigints"
  , "cardano-transaction-lib"
  , "liqwid-ctl-extra"
  , "enums"
  , "maybe"
  , "newtype"
  , "prelude"
  , "profunctor-lenses"
  , "record"
  , "tuples"
  , "arrays"
  , "effect"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
