{ hostName, pkgs, user, ... }: {
  imports = [
    ./apple-silicon/apple-silicon-support
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  hardware = {
    asahi = {
      useExperimentalGPUDriver = true;
      experimentalGPUInstallMode = "overlay";
      peripheralFirmwareDirectory = ./apple-silicon/firmware;
    };
    bluetooth = { enable = true; };
    pulseaudio = {
      package = pkgs.pulseaudioFull;
      enable = true;
    };
  };

  networking = {
    inherit hostName;
    wireless.enable = false;
    networkmanager.enable = true;
  };

  services = {
    dbus.enable = true;
    openssh.enable = true;
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

  sound.enable = true;
  console.useXkbConfig = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.${user.name} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "audio" "networkmanager" ];
      initialPassword = "password";
    };
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "23.05";
  };
}
