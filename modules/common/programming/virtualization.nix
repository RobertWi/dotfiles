{ config, pkgs, lib, ... }: {

  options.virtualization.enable = lib.mkEnableOption "Virtualizations tools.";

  config = lib.mkIf config.kubernetes.enable {

    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        # allow native virtualization VM  
        # limactl start --vm-type=vz template://ubuntu-lts 
        # a vm of choice in seconds https://lima-vm.io/docs/templates/ 
        lima 
      ];

    };
  };
}