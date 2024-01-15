{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = {self, nixpkgs}:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux = {
        label = import ./label.nix pkgs;
        note  = import ./note.nix pkgs;
        default = import ./label.nix pkgs; # Should provide all packages I guess
      };
    };
}
