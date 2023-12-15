{ hostName, pkgs, system, user, ... }: {

  imports = [ ./${system} ];

  hardware = {
    bluetooth.enable = true;
  };

  networking = {
    inherit hostName;
    wireless = {
      enable = false;
      iwd.enable = true;
    };
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  security = {
    rtkit.enable = true;
  };

  services = {
    dbus.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber.enable = true;
    };
    printing.enable = true;
    upower.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "caps:escape";
      libinput = { enable = true; };
      displayManager = { sddm.enable = true; };
    };
  };

  time = { inherit (user) timeZone; };

  sound.enable = false;
  console.useXkbConfig = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.${user.name} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "audio" "networkmanager" "docker" ];
      initialPassword = "password";
    };
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "23.05";
  };
}
