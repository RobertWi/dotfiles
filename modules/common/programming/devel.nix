{ config, pkgs, lib, ... }: {

  options = {
    devel = {
      enable = lib.mkEnableOption {
        description = "Development tools";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.devel.enable) {
    unfreePackages = [ "vscode" ];
  
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        vscode
        vscode-extensions.hashicorp.hcl   
        vscode-extensions.hashicorp.terraform
        #more to come
      ];

    };
  };
}