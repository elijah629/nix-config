{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font.name = "CaskaydiaCove Nerd Font Mono";

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      enable_audio_bell = false;
      font_size = 11.5;
      window_padding_width = 25;
      adjust_line_height = 2;
      shell = "${pkgs.nushell}/bin/nu";
    };
  };
}
