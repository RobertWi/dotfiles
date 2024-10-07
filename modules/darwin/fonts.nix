{ config, pkgs, lib, ... }: {

  home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {

    home.packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "JetbrainsMono" ]; }) ];

    programs.alacritty.settings = { font.normal.family = "JetbrainsMono"; };

    programs.kitty.font = {
      package = (pkgs.nerdfonts.override { fonts = [ "JetbrainsMono" ]; });
      name = "JetbrainsMono Nerd Font Mono";
    };

  };

}