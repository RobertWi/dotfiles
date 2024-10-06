# The MacProM3
# System configuration for my work Macbook

{ inputs, globals, ... }:

with inputs;

darwin.lib.darwinSystem {
  system = "x86_64-darwin";
  specialArgs = { };
  modules = [
    ../../modules/common
    ../../modules/darwin

    home-manager.darwinModules.home-manager
    {
      nixpkgs.overlays = [ firefox-darwin.overlay ] ++ overlays;
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