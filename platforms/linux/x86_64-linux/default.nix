{ config, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [ "kvm-intel" "wl" "b43" ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  };
  networking = {
    enableB43Firmware = true;
  };
  hardware = {
    cpu.intel.updateMicrocode = true;
  };
}
