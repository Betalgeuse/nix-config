{
  # https://github.com/dustinlyons/nixos-config/blob/main/templates/starter/flake.nix
  description = "Kangjun Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # setups
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    yazi.url = "github:sxyazi/yazi";

    workmux.url = "github:raine/workmux";
  };

  outputs =
    {
      self,
      nixpkgs,
      catppuccin,
      yazi,
      ...
    }@inputs:
    let
      lib = import ./lib inputs;
      inherit (lib) recursiveMergeAttrs mkDarwinConfig mkUserConfig;

      importedOverlays = import ./overlays inputs;
    in
    recursiveMergeAttrs [
      {
        inherit lib;
        overlays = {
          default = importedOverlays;
          yazi = yazi.overlays.default;
        };
      }
      (mkDarwinConfig {
        profile = "kj-default";
        system = "aarch64-darwin";
        userConfig = mkUserConfig {
          username = "gangjun";
          name = "Kangjun Lee";
          email = "me@gangjun.dev";
          home = "/Users/gangjun";
          nixConfig = "/Users/gangjun/nix";
        };
      })
      (mkDarwinConfig {
        profile = "kj-default-v2";
        system = "aarch64-darwin";
        userConfig = mkUserConfig {
          username = "kangjun";
          name = "Kangjun Lee";
          email = "me@gangjun.dev";
          home = "/Users/kangjun";
          nixConfig = "/Users/kangjun/nix";
        };
      })
      (mkDarwinConfig {
        profile = "zayden";
        system = "aarch64-darwin";
        userConfig = mkUserConfig {
          username = "zayden";
          name = "Zayden";
          email = "zzzaydenzz@gmail.com";
          home = "/Users/zayden";
          nixConfig = "/Users/zayden/Documents/dev-env-folder/nix-config";
        };
      })
      # hostname alias so darwin-rebuild can find the config
      {
        darwinConfigurations."zaydens-MacBook-Pro-5797" =
          self.darwinConfigurations.zayden;
        darwinConfigurations."zaydens-MacBook-Pro-5956" =
          self.darwinConfigurations.zayden;
      }
    ];
}
