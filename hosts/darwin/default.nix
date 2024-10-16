{ config, pkgs, ... }:

let user = "michal"; in

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

  environment.systemPackages = with pkgs; [
    # emacs-unstable
  ] ++ (import ../../modules/shared/packages.nix { inherit pkgs; });
  # environment.systemPackages = with pkgs; [
  #   import ../../modules/shared/packages.nix { inherit pkgs; }
  # ];

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
  
  # https://cmacr.ae/blog/yabai-module-in-nix-darwin-now-generally-available/
  services = {
#    # where is
#    yabai = {
#      # But we're pasting in a manual 4.0.0 binary from:
#      # https://github.com/koekeishiya/yabai/files/7915231/yabai-v4.0.0.tar.gz
#      enable = true;
#      package = pkgs.yabai;
#      enableScriptingAddition = false;
#      config = {
#        focus_follows_mouse          = "off";
#        mouse_follows_focus          = "off";
#        window_placement             = "second_child";
#        window_opacity               = "off";
#        window_border                = "off";
#        split_ratio                  = "0.50";
#        auto_balance                 = "off";
#        mouse_modifier               = "fn";
#        mouse_action1                = "move";
#        mouse_action2                = "resize";
#        layout                       = "bsp";
#        top_padding                  = 5;
#        bottom_padding               = 5;
#        left_padding                 = 5;
#        right_padding                = 5;
#        window_gap                   = 5;
#        extraConfig = ''
#          # rules
#
#          #yabai -m rule --add app="^System Settings$" manage=off
#          #yabai -m rule --add app='System Preferences' manage=off
#
#          # Any other arbitrary config here
#        '';
#      };
#    };
#    skhd = {
#      # Generated onfig linked to /etc/static/skhdrc (WHY?) and /etc/skhdrc and read by skhdrc?
#      enable = true;
#      package = pkgs.skhd;
#      skhdConfig = ''
#
#        # focus window
#        alt - j : yabai -m window --focus west
#        alt - k : yabai -m window --focus south
#        alt - i : yabai -m window --focus north
#        alt - l : yabai -m window --focus east
#
#        # swap window
#        shift + alt - j : yabai -m window --swap west
#        shift + alt - k : yabai -m window --swap south
#        shift + alt - i : yabai -m window --swap north
#        shift + alt - l : yabai -m window --swap east
#
#        # move window
#        shift + cmd - j : yabai -m window --warp west
#        shift + cmd - k : yabai -m window --warp south
#        shift + cmd - i : yabai -m window --warp north
#        shift + cmd - l : yabai -m window --warp east
#
#        # balance size of windows
#        shift + alt - 0 : yabai -m space --balance
#
#        # make floating window fill screen
#        shift + alt - up     : yabai -m window --grid 1:1:0:0:1:1
#
#        # make floating window fill left-half of screen
#        shift + alt - left   : yabai -m window --grid 1:2:0:0:1:1
#
#        # make floating window fill right-half of screen
#        shift + alt - right  : yabai -m window --grid 1:2:1:0:1:1
#
#        # destroy desktop
#        cmd + alt - w : yabai -m space --destroy
#
#        # fast focus desktop
#        #cmd + alt - x : yabai -m space --focus recent
#        #cmd + alt - z : yabai -m space --focus prev
#        #cmd + alt - c : yabai -m space --focus next
#        #cmd - 1 : yabai -m space --focus 1
#        #cmd - 2 : yabai -m space --focus 2
#        # #cmd - 3 : yabai -m space --focus 3
#        #cmd - 4 : yabai -m space --focus 4
#        #cmd - 5 : yabai -m space --focus 5
#        #cmd - 6 : yabai -m space --focus 6
#        #cmd - 7 : yabai -m space --focus 7
#        #cmd - 8 : yabai -m space --focus 8
#        #cmd - 9 : yabai -m space --focus 9
#        #cmd - 0 : yabai -m space --focus 10
#
#        # send window to desktop and follow focus
#        shift + cmd - x : yabai -m window --space recent; yabai -m space --focus recent
#        shift + cmd - z : yabai -m window --space prev; yabai -m space --focus prev
#        shift + cmd - c : yabai -m window --space next; yabai -m space --focus next
#        shift + cmd - 1 : yabai -m window --space  1; yabai -m space --focus 1
#        shift + cmd - 2 : yabai -m window --space  2; yabai -m space --focus 2
#        shift + cmd - 3 : yabai -m window --space  3; yabai -m space --focus 3
#        shift + cmd - 4 : yabai -m window --space  4; yabai -m space --focus 4
#        shift + cmd - 5 : yabai -m window --space  5; yabai -m space --focus 5
#        shift + cmd - 6 : yabai -m window --space  6; yabai -m space --focus 6
#        shift + cmd - 7 : yabai -m window --space  7; yabai -m space --focus 7
#        shift + cmd - 8 : yabai -m window --space  8; yabai -m space --focus 8
#        shift + cmd - 9 : yabai -m window --space  9; yabai -m space --focus 9
#        shift + cmd - 0 : yabai -m window --space 10; yabai -m space --focus 10
#
#        # focus monitor
#        #ctrl + alt - x  : yabai -m display --focus recent
#        #ctrl + alt - z  : yabai -m display --focus prev
#        #ctrl + alt - c  : yabai -m display --focus next
#        #ctrl + alt - 1  : yabai -m display --focus 1
#        #ctrl + alt - 2  : yabai -m display --focus 2
#        #ctrl + alt - 3  : yabai -m display --focus 3
#
#
#        # move window
#        shift + ctrl - a : yabai -m window --move rel:-20:0
#        shift + ctrl - s : yabai -m window --move rel:0:20
#        shift + ctrl - w : yabai -m window --move rel:0:-20
#        shift + ctrl - d : yabai -m window --move rel:20:0
#
#        # increase window size
#        shift + alt - a : yabai -m window --resize left:-20:0
#        shift + alt - s : yabai -m window --resize bottom:0:20
#        shift + alt - w : yabai -m window --resize top:0:-20
#        shift + alt - d : yabai -m window --resize right:20:0
#
#        # decrease window size
#        #shift + cmd - a : yabai -m window --resize left:20:0
#        #shift + cmd - s : yabai -m window --resize bottom:0:-20
#        #shift + cmd - w : yabai -m window --resize top:0:20
#        #shift + cmd - d : yabai -m window --resize right:-20:0
#
#        # set insertion point in focused container
#        #ctrl + alt - h : yabai -m window --insert west
#        #ctrl + alt - j : yabai -m window --insert south
#        #ctrl + alt - k : yabai -m window --insert north
#        #ctrl + alt - l : yabai -m window --insert east
#
#        # rotate tree
#        alt - r : yabai -m space --rotate 90
#
#        # mirror tree y-axis
#        alt - y : yabai -m space --mirror y-axis
#
#        # mirror tree x-axis
#        alt - x : yabai -m space --mirror x-axis
#
#        # toggle desktop offset
#        alt - a : yabai -m space --toggle padding; yabai -m space --toggle gap
#
#        # toggle window parent zoom
#        alt - d : yabai -m window --toggle zoom-parent
#
#        # toggle window fullscreen zoom
#        alt - f : yabai -m window --toggle zoom-fullscreen
#
#        # toggle window native fullscreen
#        shift + alt - f : yabai -m window --toggle native-fullscreen
#
#        # toggle window border
#        shift + alt - b : yabai -m window --toggle border
#
#        # toggle window split type
#        alt - e : yabai -m window --toggle split
#
#        # float / unfloat window and center on screen
#        alt - t : yabai -m window --toggle float;\
#                  yabai -m window --grid 4:4:1:1:2:2
#
#        # toggle sticky (show on all spaces)
#        alt - s : yabai -m window --toggle sticky
#
#        # toggle topmost (keep above other windows)
#        alt - o : yabai -m window --toggle topmost
#
#        # toggle sticky, topmost and resize to picture-in-picture size
#        alt - p : yabai -m window --toggle sticky;\
#                  yabai -m window --toggle topmost;\
#                  yabai -m window --grid 5:5:4:0:1:1
#
#        # change layout of desktop
#        ctrl + alt - a : yabai -m space --layout bsp
#        ctrl + alt - d : yabai -m space --layout float
#
#        # Custom stuff
#        #:: passthrough
#        #ctrl + cmd - p ; passthrough
#        #passthrough < ctrl + cmd - p ; default
#
#        ctrl + cmd - s : bash -c 'source ~/.bash.d/darwin && pass-choose'
#
#        ctrl + cmd - b : bash -c 'source ~/.bash.d/functions && battpop'
#        ctrl + cmd - d : bash -c 'source ~/.bash.d/functions && timepop'
#
#        cmd - space : bash -c "source ~/.bash.d/darwin && choose-launcher"
#        cmd - b : bash -c "source ~/.bash.d/darwin && choose-buku"
#        cmd + shift - k : bash -c "source ~/.bash.d/darwin && snippets"
#
#        #ctrl - 0x29 : bash -c "~/Applications/keynav.app/Contents/MacOS/XEasyMotion"
#
#        ## Control mouse with keyboard
#        #ctrl - k : cliclick "m:+0,-20" #up
#        #ctrl - j : cliclick "m:+0,+20" #down
#        #ctrl - l : cliclick "m:+20,+0" #right
#        #ctrl - h : cliclick "m:-20,+0" #left
#
#        #ctrl + shift - k : cliclick "m:+0,-40" #up
#        #ctrl + shift - j : cliclick "m:+0,+40" #down
#        #ctrl + shift - l : cliclick "m:+40,+0" #right
#        #ctrl + shift - h : cliclick "m:-40,+0" #left
#
#        #ctrl - 0x21 : cliclick ku:ctrl c:. # click
#        #ctrl - 0x1E : cliclick ku:ctrl rc:.  # right click
#      '';
#    };
  };
}