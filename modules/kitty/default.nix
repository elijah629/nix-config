{...}: {
  programs.kitty = {
    enable = true;
    font.name = "CaskaydiaCove Nerd Font Mono";

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      enable_audio_bell = false;
      font_size = 9.0;
      window_padding_width = 25;
    };
  };
}
