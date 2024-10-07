{ config, pkgs, lib, ... }: {

  unfreePackages = [ 
    "vscode"
  ];
  
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        vscode
        vscode-extensions.hashicorp.hcl   
        vscode-extensions.hashicorp.terraform
        #more to come
      ];

    };
}