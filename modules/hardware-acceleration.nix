{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiNvidia = pkgs.vaapiNvidia.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
#      nvidia-driver # NVIDIA proprietary driver
      nvidia-vaapi-driver   # LIBVA_DRIVER_NAME=nvidia (for VAAPI support with NVIDIA GPUs)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
