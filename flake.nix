{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = {self, nixpkgs}:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux = {
        note = import ./note.nix pkgs;
        label = import ./label/label.nix pkgs;
        default = import ./label/label.nix pkgs; # Should provide all packages I guess
      };
    };
}
