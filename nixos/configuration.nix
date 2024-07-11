# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
	
    ];

   # enable flakes
nix.settings.experimental-features = [ "nix-command" "flakes"];

  # allow users to install home manager apps without root 
nix.settings.allowed-users = [ "anthony"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thebirdcage"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.

services.xserver.videoDrivers = ["nvidia"];

services.gvfs.enable = true;
services.udisks2.enable = true;
services.devmon.enable = true;

hardware.nvidia = {
	modesetting.enable = true;
#	powerManagement.enable = false;
#	powerManagerment.finegrained = false;
	open = false;
	nvidiaSettings = true;
	package = config.boot.kernelPackages.nvidiaPackages.stable;
};

hardware.nvidia.forceFullCompositionPipeline = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "au";
    xkb.variant = "";
  };

# fonts
fonts = {
		packages = with pkgs; [
			noto-fonts
			noto-fonts-cjk
			noto-fonts-emoji
			font-awesome
			source-han-sans
			];
	fontconfig.defaultFonts = {
		serif = ["Noto Serif Source" "Han Serif"];
		sansSerif = [ "Noto Sans" "Source Han sans"];
	};
};

  # Enable CUPS to print documents.
  services.printing.enable = true;
#  hardware.graphics.enable = true;
  hardware.opengl.enable = true;
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; 
    jack.enable = true;
  };
security.polkit.enable = true;

security.pam.loginLimits = [
	{ domain = "@users"; item="rtprio"; type="-"; value =1; }
	{ domain = "@audio"; item="memlock"; type="-"; value="unlimited"; }
];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anthony = {
    isNormalUser = true;
    description = "anthony";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 
  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true; 


 programs.sway =  {
		enable = true;
		wrapperFeatures.gtk = true;
 };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    htop
    git
    git-crypt
    curl
   btrfs-progs
    gh

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?


#Environment variablle
environment.sessionVariables = {
	WLR_NO_HARDWARE_CURSORS= "1";
#	NIXPKGS_ALLOW_UNFREE="1";	
	};

}
