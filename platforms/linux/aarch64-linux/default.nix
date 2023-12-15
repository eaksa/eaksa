_: {
  imports = [
    ./apple-silicon-support
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    extraModprobeConfig = ''
      options hid_apple swap_fn_leftctrl=1
    '';
    m1n1CustomLogo = ./boot_logo.png;
  };

  hardware = {
    asahi = {
      useExperimentalGPUDriver = true;
      experimentalGPUInstallMode = "overlay";
      peripheralFirmwareDirectory = ./firmware;
    };
  };
}
