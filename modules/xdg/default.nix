{ ... }:
{
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      associations.added = {
        "x-scheme-handler/http" = [ "librewolf.desktop" ];
        "x-scheme-handler/https" = "librewolf.desktop";
      };
    };

    userDirs = {
      setSessionVariables = true;
      enable = true;
      createDirectories = true;
    };
  };
}
