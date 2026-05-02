{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Catppuccin
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim setup
    toucanvim = {
      url = "github:elijah629/touca.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spotify addons
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland?ref=v0.54.3";
      # Hyprland cache does not support custom nixpkgs versions
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprsplit = {
      url = "github:shezdy/hyprsplit"; # "/e655de2ef61b19ca28aa9976104f1733ea57cdea";
      inputs.hyprland.follows = "hyprland";
    };

    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    codex-nix = {
      url = "github:SecBear/codex-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    finamp-flake = {
      url = "github:elijah629/finamp-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musee = {
      url = "github:elijah629/musee";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      catppuccin,
      home-manager,
      spicetify-nix,
      claude-code,
      ...
    }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };

          modules = [
            ./modules/system/configuration.nix

            {
              nixpkgs.overlays = [
                claude-code.overlays.default
                (self: super: {
                  nomachine-client = super.nomachine-client.overrideAttrs (oldAttrs: {
                    src = super.fetchurl {
                      url = "https://web9001.nomachine.com/download/9.4/Linux/nomachine_9.4.14_1_x86_64.tar.gz";
                      hash = "sha256-tLL8l/UgTiVzGs+mwJeRUlVA8lH72JVogBOEpaSr2AY=";
                    };
                  });
                })
              ];
            }

            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };

                users.user = {
                  imports = [
                    ./users/user.nix

                    catppuccin.homeModules.catppuccin
                    spicetify-nix.homeManagerModules.default
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
