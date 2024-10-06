{ config, pkgs, lib, ... }: {


    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        lima #allow native virtualization start with limactl start --vm-type=vz 
      ];

    };
}