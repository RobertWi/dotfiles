{ config, pkgs, lib, ... }: {

  # Homebrew - Mac-specific packages that aren't in Nix
  config = lib.mkIf pkgs.stdenv.isDarwin {

    # Requires Homebrew to be installed
    system.activationScripts.preUserActivation.text = ''
      if ! xcode-select --version 2>/dev/null; then
        $DRY_RUN_CMD xcode-select --install
      fi
      if ! /usr/local/bin/brew --version 2>/dev/null; then
        $DRY_RUN_CMD /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
    '';

    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = false; # Don't update during rebuild
        cleanup = "zap"; # Uninstall all programs not declared
        upgrade = true;
      };
      global = {
        brewfile = true; # Run brew bundle from anywhere
        lockfiles = false; # Don't save lockfile (since running from anywhere)
      };
  #    taps = [
  #      "" 
  #    ];
      brews = [
        "trash" # Delete files and folders to trash instead of rm
        "mas" 
      ];
      casks = [
        "podman-desktop"  # da container dekstop pulls in podman as well. 
        "firefox" # not available on aarch64-apple-darwin
        "joplin" #marked as broken in nixos
        "mongodb-compass" # not available on aarch64-apple-darwin
        "nosqlbooster-for-mongodb" # not available on nix
        "leapp" 
      ];
      # masApps needs ID with mas cli > mas search Yoink
      masApps = {
        "Strongbox" = 897283731;
      };
    };

  };

}
