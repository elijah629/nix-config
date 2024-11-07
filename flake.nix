{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Neovim setup
    nixvim.url = "github:dc-tec/nixvim";

    # NUR for firefox addons
    nur.url = "github:nix-community/NUR";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      catppuccin,
      home-manager,
      nixvim,
      nur,
      spicetify-nix,
      ...
    }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/system/configuration.nix
          { nixpkgs.overlays = [ nur.overlay ]; }
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.user = {
              imports = [
                (import ./users/user.nix inputs)
                catppuccin.homeManagerModules.catppuccin
                spicetify-nix.homeManagerModules.default
              ];
            };
          }
        ];
      };
    };
}
