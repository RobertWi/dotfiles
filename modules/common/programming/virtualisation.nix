{ config, pkgs, lib, ... }: {

  options = {
    virtualisation = {
      enable = lib.mkEnableOption {
        description = "Enable virtualisation";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.virtualisation.enable) {

    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        # allow native virtualization VM  
        # limactl start --vm-type=vz template://ubuntu-lts 
        # a vm of choice in seconds https://lima-vm.io/docs/templates/ 
        lima
        nerctl
        qemu
        podman
      ];  
     };
  };
}