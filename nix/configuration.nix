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

    settings = {
      trusted-users = [
        "root"
        "azharprabudi"
      ];
      
      extra-substituters = https://devenv.cachix.org;
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  system.defaults = {
    # minimal dock
    dock = {
      tilesize = 32;
      autohide = true;
      show-recents = false;
      persistent-apps = [
        "/Applications/DBeaver.app"
        "/Applications/Docker.app"
        "/Applications/Visual\ Studio\ Code.app"
        "/Applications/Google\ Chrome.app"
        "/Applications/WezTerm.app"
        "/Applications/Wireshark.app"
        "/Applications/VirtualBox.app"
      ];
      persistent-others = [
        "~/Downloads"
      ];
    };

    trackpad = {
      Clicking = true;
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
    meslo-lgs-nf
  ];

  homebrew = {
    enable = true;

    # TODO: Enable it for clean laptop
    casks = [
      "capcut"
      "cloudflare-warp"
      "dbeaver-community"
      "docker"
      "dockx"
      "kindle-comic-creator"
      "kindle-comic-converter"
      "raycast"
      "rectangle"
      "transfer"
      "virtualbox@beta"
      "visual-studio-code"
      "wireshark"
      "wezterm"
      "mullvadvpn"
      "netbirdio/tap/netbird-ui"
   ];
  };
}
