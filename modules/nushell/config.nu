$env.config.buffer_editor = "nvim"

def "nix upgrade" [] {
  sudo nix flake update --flake /etc/nixos
}

def "nix update" [] {
  sudo nixos-rebuild switch --flake /etc/nixos#nixos
}

def "reboot windows" [] {
  sudo efibootmgr -n 0000;
  sudo reboot
}

# Edits the nixos config for the system
def "config nixos" [] {
  let editor = ($env.config.buffer_editor | default "nano")

  cd "/etc/nixos";
  ^$editor .
}

def "nix clean" [] {
  sudo nix profile wipe-history;
  sudo nix store gc -v;
  sudo nix store optimise;
}
