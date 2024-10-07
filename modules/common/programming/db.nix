{ config, pkgs, lib, ... }: {


    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        mongodb-tools
        mongodb-compass
        mongosh
      ];

    };
}