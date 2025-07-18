{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;

    profiles.default.extensions.force = true;
    /*
      profiles = {
         default = {
           name = "default";
           search = {
             default = "Brave";
             privateDefault = "Brave";

             engines = {
               "Brave" = {
                 urls = [
                   {
                     template = "https://search.brave.com/search?q={searchTerms}";
                   }
                 ];
                 icon = "https://cdn.search.brave.com/serp/v2/_app/immutable/assets/favicon-32x32.B2iBzfXZ.png";
                 definedAliases = ["@br"];
               };
             };
             force = true;
           };

           settings = {
             "extensions.autoDisableScopes" = 0;
             "webgl.disabled" = false; # See [1], WebGL is nice
             "browser.download.lastDir" = "~/Downloads";
           };
         };
       };
    */
  };
}
