{
  description = "agora-purescript-bridge";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    liqwid-nix = {
      url = "github:Liqwid-Labs/liqwid-nix/v2.7.2";
      inputs.nixpkgs-latest.follows = "nixpkgs-latest";
    };

    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-ctl.follows = "cardano-transaction-lib/nixpkgs";
    nixpkgs-latest.url = "github:NixOS/nixpkgs?rev=a2494bf2042d605ca1c4a679401bdc4971da54fb";

    cardano-transaction-lib = {
      type = "github";
      owner = "Plutonomicon";
      repo = "cardano-transaction-lib";
      # NOTE
      # This should match the same revision as the one in your `packages.dhall` to ensure
      # the greatest compatibility
      ref = "v5.0.0";
    };

    liqwid-ctl-extra = {
      url = "git+ssh://git@github.com/Liqwid-Labs/liqwid-ctl-extra.git";
      inputs = {
        ctl.follows = "cardano-transaction-lib";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs@{ self, liqwid-nix, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.liqwid-nix.flakeModule
      ];
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux" ];

      perSystem = { config, pkgs', self', inputs', system, ... }:
        let
          pkgs = import inputs.nixpkgs-latest {
            inherit system;

            overlays = [
              inputs.cardano-transaction-lib.overlays.purescript
              inputs.cardano-transaction-lib.overlays.runtime
              inputs.cardano-transaction-lib.overlays.spago
            ];
          };
        in
        {
          pre-commit = {
            settings = {
              src = ./.;
              excludes = [ "spago-packages.nix" ];
              hooks = {
                nixpkgs-fmt.enable = true;
                purs-tidy.enable = true;
                dhall-format.enable = true;
              };
            };
          };

          offchain.default = {
            src = ./.;

            spagoOverride = {
              "liqwid-ctl-extra" = inputs.liqwid-ctl-extra;
            };

            packageLock = ./package-lock.json;
            packageJson = ./package.json;

            runtime = {
              enableCtlServer = false;
              exposeConfig = false;
            };

            ignoredWarningCodes = [
              "ImplicitImport"
              "UserDefinedWarning"
              "WildcardInferredType"
            ];

            shell.extraCommandLineTools = [
              pkgs.dhall
              pkgs.fd
              pkgs.nodejs
              pkgs.nodePackages.npm
              pkgs.xdg-utils
              pkgs.gnumake
            ];

            enableFormatCheck = true;
            # NOTE(Emily, 16 Jan 2023): Low priority. This is kinda broken right now.
            #
            # TypeScript lint checking is non-trivial with nix.
            enableJsLintCheck = false;

            plutip = { testMain = "Test.Main"; };
            tests = { testMain = "Test.Main"; };
          };

          ci.required = [ "all_offchain" ];
        };

      flake.hydraJobs.x86_64-linux = (
        self.checks.x86_64-linux
        // self.packages.x86_64-linux
      );
    };
}
