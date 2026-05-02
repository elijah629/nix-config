let tty_info = (^tty | complete)

if $tty_info.exit_code == 0 and ($tty_info.stdout | str trim) == "/dev/tty1" {
  ^start-hyprland
  exit
}
