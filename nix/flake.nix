{
  description = "Hugo Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
            # Applications
            pkgs.neovim
            pkgs.ansible
            pkgs.docker
            pkgs.wget

            # Installation Management
            pkgs.fnm
            pkgs.uv
            pkgs.pnpm

            # Dependencies
            pkgs.xz
            pkgs.git-lfs

            # Tools
            pkgs.htop
            pkgs.jq
            pkgs.ripgrep
            pkgs.git
            pkgs.starship
            pkgs.stow
            pkgs.bat
            pkgs.eza
            pkgs.ffmpeg
            pkgs.fzf
            pkgs.imagemagick
            pkgs.hyperfine
            pkgs.yazi
            pkgs.zoxide
            pkgs.moreutils

            # Languages
            pkgs.go
            pkgs.python312

            # User Interface
            pkgs.jankyborders

            # Misc
            pkgs.mkalias
        ];

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      homebrew = {
          enable = true;
          taps = [
            "felixkratz/formulae"
            "nikitabobko/tap"
          ];
          casks = [
            "wezterm"
            "shortcat"
            "vlc"
            "nikitabobko/tap/aerospace"
          ];
          brews = [
            "gnu-sed"
            "gnupg"
            {
              name = "tmux";
              args = ["HEAD"];
            }
            "felixkratz/formulae/sketchybar"
            "watch"
          ];
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
      };

      launchd = {
        user = {
          agents = {
            sketchybar = {
              command = "/opt/homebrew/bin/sketchybar --config ~/.config/sketchybar/sketchybarrc --hotload";
              path = ["${config.environment.systemPath}:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:/bin:/usr/sbin:/sbin"];
              serviceConfig = {
                KeepAlive = true;
                RunAtLoad = true;
                StandardOutPath = "/tmp/log/sketchybar.out.log";
                StandardErrorPath = "/tmp/log/sketchybar.err.log";
              };
            };
          };
        };
      };

      system.defaults = {
        dock.autohide = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        NSGlobalDomain = {
          AppleICUForce24HourTime = true;
          KeyRepeat = 2;
          InitialKeyRepeat = 15;
        };
      };

      # Sudo via TouchID
      security.pam.enableSudoTouchIdAuth = true;

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
      in
          pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
          '';

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
      modules = [ 
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true; # Apple Silicon
              user = "hugo";
            };
          }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macos".pkgs;
  };
}