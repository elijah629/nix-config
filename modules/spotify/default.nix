{
  pkgs,
  inputs,
  ...
}:
{
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
        trashbin
      ];
      enabledCustomApps = with spicePkgs.apps; [
        lyricsPlus
      ];
      theme = spicePkgs.themes.comfy;
      colorScheme = "catppuccin-mocha";
    };
}
