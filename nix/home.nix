{ pkgs, config, ... }:
let

  treesitterWithGrammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.comment
    p.cmake
    p.cue
    p.dockerfile
    p.git_config
    p.gitattributes
    p.gitignore
    p.go
    p.gomod
    p.gosum
    p.gowork
    p.gotmpl
    p.hcl
    p.helm
    p.jq
    p.json
    p.json5
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.solidity
    p.terraform
    p.toml
    p.yaml
  ]));

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in
{

  home = {
    stateVersion = "24.05";

    packages = with pkgs; [
      jq
      yq
      hey
      meld
      curl
      lazygit
      docker
      docker-compose
      devenv
      neofetch
      coreutils
      kafkactl
      kustomize
      inetutils
      chatgpt-cli
      jsonnet
      unixtools.watch
      (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])

      argocd
      python3
      nodejs_22
      go_1_21
      gosec
      go-rice
      go-tools
      go-mockery
      go-swagger
      govulncheck
      golangci-lint
      luajitPackages.luarocks
      ssm-session-manager-plugin

      kn
      func
      ansible
      ansible-lint
      molecule
      kail
      kind
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
      sqlite
      postgresql_16
      mysql84
      devcontainer
    ];

    sessionPath = [
      "$HOME/go/bin"
    ];

    sessionVariables = {
      # TODO: Change to Chat GPT Open API Key
      OPENAI_API_KEY = "xxxxx";
      KUBECTL_EXTERNAL_DIFF = "meld";
    };

    shellAliases = {
      lg = "lazygit";
      ipext="curl https://icanhazip.com";
      meld = "meld_script(){ /Applications/Meld.app/Contents/MacOS/Meld $* 2>/dev/null & };meld_script";
    };

    file = {
      # dotfiles
      ".curlrc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.curlrc";
      };

      ".editorconfig" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.editorconfig";
      };

      ".config/nvim/init.lua" = {
        text = ''
          require("config.remap")
          require("config.options")
          require("config.lazy")
          vim.opt.runtimepath:append("${treesitter-parsers}")
        '';
      };

      ".config/wezterm" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/wezterm";
        recursive = true;
      };

      ".config/nvim/lua" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim/lua";
        recursive = true;
      };

      # Treesitter is configured as a locally developed module in lazy.nvim
      # we hardcode a symlink here so that we can refer to it in our lazy config
      ".local/share/nvim/nix/nvim-treesitter/" = {
        recursive = true;
        source = treesitterWithGrammars;
      };

      # dotfile folders dependencies
      ".config/zsh/.p10k.zsh" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/zsh/.p10k.zsh";
      };

      "images" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/images";
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
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      vimdiffAlias = true;
      defaultEditor = true;
      package = pkgs.neovim-unwrapped;

      coc = {
        enable = false;
      };

      plugins = [
        treesitterWithGrammars
      ];
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
        eval "$(/opt/homebrew/bin/brew shellenv)"
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
