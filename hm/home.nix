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
#			pkgs.hyprland
#			pkgs.hyprpaper
			pkgs.autotiling
			pkgs.ardour
			pkgs.kitty
			pkgs.rofi-wayland
			pkgs.wl-clipboard
			pkgs.waybar
			pkgs.gh
			pkgs.ffmpeg-full
			pkgs.kdenlive
			pkgs.mpv
	];
			
	wayland.windowManager.hyprland = {
		enable = true;
		package = pkgs.hyprland;
		xwayland.enable = true;
	};

	wayland.windowManager.hyprland.settings = {
		decoration = {
			shadow_offset = "0.5";
			"col.shadow" = "rgba(00000099)";
		};
		"$mod" = "SUPER";
		bindm = [
			"$mod, mouse:272, movewindow"
			"$mod, mouse:272, resizewindow"
			"$mod ALT, mouse:272, resizewindow"
		];
	};	

 	programs.bash = {
		enable =true;
		shellAliases = {
			sww = "sway --unsupported-gpu";
		};
	};	


	programs.home-manager.enable  = true;	
	nixpkgs.config.allowUnfree = true;
}	
