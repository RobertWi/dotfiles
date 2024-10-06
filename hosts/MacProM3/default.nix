# The MacProM3
# System configuration for my work Macbook

{ inputs, globals, overlays, ... }:

  globals
      // rec {
        user = "Noah.Masur";
        gitName = "Noah-Masur_1701";
        gitEmail = "${user}@take2games.com";
      }
    )

inputs.darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = { };
  modules = [
    ../../modules/common
    ../../modules/darwin
    ( #something is wrong here not using global set in flake.nix 
    globals
      // rec {
        user = "robertwinder";
        gitName = "RobertWi";
        gitEmail = "${gitName}@take2games.com";
      }
    )  

    inputs.home-manager.darwinModules.home-manager
    inputs.mac-app-util.darwinModules.default
    {
      networking.hostName = "MacProM3";
      identityFile = "/Users/Robert.Winder/.ssh/id_ed25519";
      gui.enable = true;
      firefox.enable = true;
      dotfiles.enable = true;
      nixlang.enable = true;
      terraform.enable = true;
      kubernetes.enable = true;
    }
  ];
}