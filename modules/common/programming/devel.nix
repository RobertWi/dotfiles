{ config, pkgs, lib, ... }: {

  unfreePackages = [ 
    "vscode-with-extensions"
    "vscode-extensions.github.copilot"
    "vscode-extensions.github.chat"
  ];
  
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        vscode-with-extensions
        vscode-extensions.hashicorp.hcl
        vscode-extensions.github.copilot #private use not allowed on work repos
        vscode-extensions.github.copilot-chat #private use not allowed on work repos    
        vscode-extensions.hashicorp.terraform

      ];

    };
}