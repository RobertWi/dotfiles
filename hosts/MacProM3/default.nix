# The MacProM3
# System configuration for my work Macbook

{ inputs, globals, overlays, ... }:



inputs.darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = { };
  modules = [
    ../../modules/common
    ../../modules/darwin

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