{ config, pkgs, ... }:
 
{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon = {
    enable = true;
  };
  
  nix = {
    extraOptions = ''
      auto-optimise-store = true
      extra-experimental-features = nix-command flakes
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };
  
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  system.defaults = {
    # minimal dock
    dock = {
      autohide = true;
      show-recents = false;
      persistent-apps = [
        "/Applications/DBeaver.app"
        "/Applications/Google\ Chrome.app"
        "/Applications/Slack.app"
        "/Applications/Spotify.app"
        "/Applications/WezTerm.app"
        "/Applications/Wireshark.app"
        "/Applications/zoom.us.app"
      ];
      persistent-others = [
        "~/kondel"
      ];
    };

    # a finder that tells me what I want to know and lets me work
    finder = {
      ShowPathbar = true;
      ShowStatusBar = true;
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
    };

    # Tab between form controls and F-row that behaves as F1-F12
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      AppleShowScrollBars = "Automatic";
      "com.apple.keyboard.fnState" = true;
      "com.apple.trackpad.forceClick" = true;
      "com.apple.swipescrolldirection" = false;
    };

    # Security hardening
    loginwindow = {
      GuestEnabled = false;
    };
    
    alf = {
      stealthenabled = 1;
    };
  };

  time = {
    timeZone = "Asia/Bangkok";
  };

  fonts.packages = with pkgs; [
    nerdfonts
    meslo-lg
  ];
  
  homebrew = {
    enable = true;

    # TODO: Enable it for clean laptop
    # casks = [
      # "capcut"
      # "cloudflare-warp"
      # "dbeaver-community"
      # "discord"
      # "docker"
      # "dockx"
      # "google-chrome"
      # "kindle-comic-creator"
      # "kindle-comic-converter"
      # "lofi"
      # "notion"
      # "openvpn-connect"
      # "postman"
      # "pritunl"
      # "raycast"
      # "rectangle"
      # "slack"
      # "transfer"
      # "virtualbox@beta"
      # "visual-studio-code"
      # "wireshark"
      # "wezterm"
      # "zoom"
    # ];
  };
}