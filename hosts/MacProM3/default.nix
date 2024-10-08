# The MacProM3
# System configuration for my work Macbook

{ inputs, globals, overlays, ... }:

inputs.darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = { };
  modules = [
    ../../modules/common
    ../../modules/darwin
    #something is wrong here not using global set in flake.nix 
    ( 
      globals
      // rec {
        user = "robertwinder";
        gitName = "RobertWi";
        gitEmail = "1311049+RobertWi@users.noreply.github.com";
      }
    )  
    inputs.home-manager.darwinModules.home-manager
    inputs.mac-app-util.darwinModules.default
    {
      networking.hostName = "MacProM3";
      identityFile = "/Users/${globals.user}/.ssh/id_ed25519";
      db.enable = true;
      devel.enable = true; 
      gui.enable = true;
      firefox.enable = true;
      dotfiles.enable = true;
      nixlang.enable = true;
      lua.enable = true;
      obsidian.enable = true;
      terraform.enable = true;
      kubernetes.enable = true;
      virtualizations.enable = true; 
    }
  ];
}