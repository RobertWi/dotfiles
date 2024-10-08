{ config, pkgs, lib, ... }: {

  options = {
    db = {
      enable = lib.mkEnableOption {
        description = "Database tools";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.db.enable) {
    unfreePackages = [ "mongodb-compass" ];

    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        #mongodb-compass no aarch64-apple-darwin available move to brew
        mongodb-tools
        mongosh
      ];

    };
  };  
}