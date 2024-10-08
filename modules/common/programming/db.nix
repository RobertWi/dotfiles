{ config, pkgs, lib, ... }: {

  options.db.enable = lib.mkEnableOption "Database tools.";

  config = lib.mkIf config.kubernetes.enable {

    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        mongodb-tools
        mongosh
      ];

    };
  };  
}