{
  description = "My system";

  # Other flakes that we want to pull from
  inputs = {

    # Used for system packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Used for MacOS system config
    darwin = {
      url = "github:/lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Used for Windows Subsystem for Linux compatibility
    wsl.url = "github:nix-community/NixOS-WSL";

    # Used for user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows =
        "nixpkgs"; # Use system packages list where available
    };

    # Community packages; used for Firefox extensions
    nur.url = "github:nix-community/nur";

    # Use official Firefox binary for macOS
    firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";

    # Used to generate NixOS images for other platforms
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Convert Nix to Neovim config
    nix2vim = {
      url = "github:gytis-ivaskevicius/nix2vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix language server
    nil.url = "github:oxalica/nil/2023-04-03";

  };

  outputs = { nixpkgs, ... }@inputs:

    let

      # Global configuration for my systems
      globals = rec {
        user = "RobertWi";
        fullName = "Robert.Wi";
        gitName = fullName;
        gitEmail = "1311049+RobertWi@users.noreply.github.com";
        mail.server = "doemijdiemailmaar.nl";
        mail.imapHost = "mail.doemijdiemailmaar.nl";
        mail.smtpHost = "mail.doemijdiemailmaar.nl";
        dotfilesRepo = "github.com:RobertWi/dotfiles";
      };

      # Common overlays to always use
      overlays = [
        inputs.nur.overlay
        inputs.nix2vim.overlay
        (import ./overlays/neovim-plugins.nix inputs)
        (import ./overlays/lib.nix)
        (import ./overlays/calibre-web.nix)
      ];


      # System types to support.
      supportedSystems =
        [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    in rec {

      # Contains my full Mac system builds, including home-manager
      # darwin-rebuild switch --flake .#MacProM3
      darwinConfigurations = {
        MacProM3 =
          import ./hosts/MacProM3 { inherit inputs globals overlays; };
      };

      homeConfigurations = {
        MacProM3 =
          darwinConfigurations.MacProM3.config.home-manager.users."Robert.Winder".home;
      };
     
      # Development environments
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system overlays; };
        in {

          # Used to run commands and edit files in this repo
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ git stylua nixfmt shfmt shellcheck ];
          };

          # Used for cloud and systems development and administration
          devops = pkgs.mkShell {
            buildInputs = with pkgs; [
              git
              terraform
              consul
              vault
              awscli2
              google-cloud-sdk
              ansible
              kubectl
              kubernetes-helm
              kustomize
              fluxcd
            ];
          };
        });
  };
} 