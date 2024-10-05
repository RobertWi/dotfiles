{ config, pkgs, lib, ... }: {

  config = lib.mkIf pkgs.stdenv.isDarwin {
    networking = {
      computerName = "${config.fullName}";
      # Adjust if necessary
      # hostName = "";
    };
  };

}