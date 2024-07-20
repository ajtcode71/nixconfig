{
	description = "My flake.nix";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... } @inputs: {
		nixpkgs.config.allowUnfree = true;
		nixosConfigurations.thebirdcage = nixpkgs.lib.nixosSystem {
			system="x86_64-linux";
			modules = [ 
				./configuration.nix
			];
		};
	};
}

