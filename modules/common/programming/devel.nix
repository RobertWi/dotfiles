{ config, pkgs, lib, ... }: {

  unfreePackages = [ 
    "vscode-with-extensions"
  ];
  
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        vscode-with-extensions
        vscode-extensions.hashicorp.hcl   
        vscode-extensions.hashicorp.terraform
        #more to come
      ];

    };
}