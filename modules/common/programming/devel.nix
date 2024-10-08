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
    unfreePackages = [ 
      "vscode"
      "vscode-extensions.github.copilot"
      "vscode-extensions.github.copilot-chat"
    ];
  
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        vscode
       #fixme not adhering to unfree above
       # vscode-extensions.github.copilot
       # vscode-extensions.github.copilot-chat
        vscode-extensions.hashicorp.hcl   
        vscode-extensions.hashicorp.terraform
        #more to come
      ];

    };
  };
}