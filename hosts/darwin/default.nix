{ config, pkgs, ... }:

let user = "mk058946"; in

{
  imports = [
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
  ];

  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = [ "@admin" "${user}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.checks.verifyNixPath = false;

  # environment.systemPackages = with pkgs; [
  #   emacs-unstable
  # ] ++ (import ../../modules/shared/packages.nix { inherit pkgs; });

  # launchd.user.agents.emacs.path = [ config.environment.systemPath ];
  # launchd.user.agents.emacs.serviceConfig = {
  #   KeepAlive = true;
  #   ProgramArguments = [
  #     "/bin/sh"
  #     "-c"
  #     "/bin/wait4path ${pkgs.emacs}/bin/emacs && exec ${pkgs.emacs}/bin/emacs --fg-daemon"
  #   ];
  #   StandardErrorPath = "/tmp/emacs.err.log";
  #   StandardOutPath = "/tmp/emacs.out.log";
  # };

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2(default)
        InitialKeyRepeat = 15; # Values: 120, 94, 68, 35, 25, 15(default)

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.swipescrolldirection" = false;
      };

      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };
  
  # services.yabai = {
  #   # But we're pasting in a manual 4.0.0 binary from:
  #   # https://github.com/koekeishiya/yabai/files/7915231/yabai-v4.0.0.tar.gz
  #   enable = true;
  #   package = pkgs.yabai;
  #   enableScriptingAddition = false;
  #   config = {
  #     focus_follows_mouse          = "off";
  #     mouse_follows_focus          = "off";
  #     window_placement             = "second_child";
  #     window_opacity               = "off";
  #     window_border                = "off";
  #     split_ratio                  = "0.50";
  #     auto_balance                 = "off";
  #     mouse_modifier               = "fn";
  #     mouse_action1                = "move";
  #     mouse_action2                = "resize";
  #     layout                       = "bsp";
  #     top_padding                  = 30;
  #     bottom_padding               = 30;
  #     left_padding                 = 30;
  #     right_padding                = 30;
  #     window_gap                   = 30;
  #     yabai -m rule --add app="^System Settings$" manage=off
  #   };
  # };
}