{ pkgs, config, ... }:
 
{

  home = {
    stateVersion = "24.05";
    
    packages = with pkgs; [
      jq
      yq
      hey
      curl
      lazygit
      devenv
      neofetch
      coreutils
      kafkactl
      inetutils
      chatgpt-cli
      unixtools.watch
      (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])

      nodejs_22
      go_1_21
      gosec
      go-rice
      go-tools
      go-mockery
      go-swagger
      govulncheck
      golangci-lint

      kn
      func
      ansible
      ansible-lint
      molecule
      kubectl
      kubectx
      kubent
      kube-score
      kubectl-neat
      kubernetes-helm
      terraform
      terraform-docs
      tflint
      tfsec
      istioctl
      packer
      kubeseal
      redis
      mongosh
      postgresql_16
      mysql84
      devcontainer
    ];

    sessionVariables = {
      # TODO: Change to Chat GPT Open API Key
      OPENAI_API_KEY = "xxxxx";
    };

    shellAliases = {
      lg = "lazygit";
    };

    file = {
      # dotfiles
      ".curlrc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/mmos/dotfiles/.curlrc";
      };

      ".editorconfig" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/mmos/dotfiles/.editorconfig";
      };

      ".config/wezterm" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/mmos/dotfiles/wezterm";
        recursive = true;
      };

      # dotfile folders dependencies
      ".config/zsh/.p10k.zsh" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/mmos/dotfiles/zsh/.p10k.zsh";
      };

      "images" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/mmos/dotfiles/images";
        recursive = true;
      };
    };
  };
  

  programs = {
    fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git/"
      ];
    };

    fzf.enable = true;
    gpg.enable = true;
    htop.enable = true;
    awscli.enable = true;
    direnv.enable = true;
    thefuck.enable = true;
    dircolors.enable = true;
    home-manager.enable = true;

    # replacement for command-not-found
    nix-index.enable = true;

    git = {
      enable = true;
      userName = "azharprabudi";
      userEmail = "azharprabui@gmail.com";

      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;

      coc = {
        enable = true;
      };
    };

    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      autosuggestion = {
        enable = true;
      };

      syntaxHighlighting = {
        enable = true;
      };

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];

      initExtra = ''
        # Powerlevel10k Zsh theme  
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme  
        test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh  
      '';

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "ansible"
          "aws"
          "colorize" 
          "docker"
          "docker-compose"
          "encode64"
          "fzf"
          "git" 
          "git"
          "history"
          "jsontools"
          "kubectl"
          "systemadmin"
          "terraform"
          "z"
          "thefuck"
        ];
      };
    };
  };
}