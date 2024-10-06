{ config, pkgs, lib, ... }:

{

  options = {
    firefox = {
      enable = lib.mkEnableOption {
        description = "Enable Firefox.";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.firefox.enable) {
    
    home-manager.users.${config.user} = {
      programs.firefox = {
        enable = true;
        package =
        #install ff with brew no aarch64-apple-darwin package available
          if pkgs.stdenv.isDarwin then null else pkgs.firefox;
        profiles.default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "app.update.auto" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.warnOnQuit" = false;
            "browser.quitShortcut.disabled" =
              if pkgs.stdenv.isLinux then true else false;
            "browser.theme.dark-private-windows" = true;
            "browser.toolbars.bookmarks.visibility" = false;
            "browser.startup.page" = 3; # Restore previous session
            "browser.newtabpage.enabled" = false; # Make new tabs blank
            "trailhead.firstrun.didSeeAboutWelcome" =
              true; # Disable welcome splash
            "dom.forms.autocomplete.formautofill" = false; # Disable autofill
            "extensions.formautofill.creditCards.enabled" =
              false; # Disable credit cards
            "dom.payments.defaults.saveAddress" = false; # Disable address save
            "general.autoScroll" = true; # Drag middle-mouse to scroll
            "services.sync.prefs.sync.general.autoScroll" =
              false; # Prevent disabling autoscroll
            "extensions.pocket.enabled" = false;
            "toolkit.legacyUserProfileCustomizations.stylesheets" =
              true; # Allow userChrome.css
            "layout.css.color-mix.enabled" = true;
            "ui.systemUsesDarkTheme" =
              if config.theme.dark == true then 1 else 0;
            "media.ffmpeg.vaapi.enabled" =
              true; # Enable hardware video acceleration
            "cookiebanners.ui.desktop.enabled" = true; # Reject cookie popups
          };
        extraConfig = "";
        };

      };

      xsession.windowManager.i3.config.keybindings =
        lib.mkIf pkgs.stdenv.isLinux {
          "${
            config.home-manager.users.${config.user}.xsession.windowManager.i3.config.modifier
          }+Shift+b" = "exec ${
            # Don't name the script `firefox` or it will affect grep
              builtins.toString (pkgs.writeShellScript "focus-ff.sh" ''
                count=$(ps aux | grep -c firefox)
                if [ "$count" -eq 1 ]; then
                    i3-msg "exec --no-startup-id firefox"
                    sleep 0.5
                fi
                i3-msg "[class=firefox] focus"
              '')
            }";
        };

    };

  };

}