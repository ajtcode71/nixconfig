{ config, pkgs, ... } :

#users.users.anthony.isNormalUser = true;
{
	home.username = "anthony";
	home.homeDirectory = "/home/anthony";
	home.stateVersion = "24.05";
	home.packages = [ 
			pkgs.darktable
			pkgs.sway
			pkgs.feh
			pkgs.qimgv
			(pkgs.blender.override { cudaSupport = true ;} )
			pkgs.pcmanfm
			pkgs.yazi
			pkgs.wofi
			pkgs.hyprland
			pkgs.hyprpaper
			pkgs.autotiling
			pkgs.ardour
			pkgs.kitty
			pkgs.rofi-wayland
			pkgs.wl-clipboard
			pkgs.waybar
			pkgs.gh
	];
			
 	programs.bash = {
		enable =true;
		shellAliases = {
			sww = "sway --unsupported-gpu";
		};
	};	
	programs.home-manager.enable  = true;	
	nixpkgs.config.allowUnfree = true;
}	
