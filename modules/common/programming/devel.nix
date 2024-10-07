{ config, pkgs, lib, ... }: {

  unfreePackages = [ 
    "vscode-with-extensions"
    "vscode"
  ];
  
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        vscode
        vscode-with-extensions
        vscode-extensions.hashicorp.hcl   
        vscode-extensions.hashicorp.terraform
        #more to come
      ];

    };
}