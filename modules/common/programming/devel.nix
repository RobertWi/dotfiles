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
        vscode-extensions.github.copilot #private use not allowed on work repos
        vscode-extensions.github.copilot-chat #private use not allowed on work repos    
        vscode-extensions.hashicorp.terraform

      ];

    };
}