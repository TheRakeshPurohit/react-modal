{
  description = "react-modal flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inputs = with pkgs; [pkg-config nodejs_22 openssl];
      in {
        devShell = pkgs.mkShell {
          name = "react-modal";
          buildInputs = inputs;
          shellHook = ''
 export EDITOR=emacs;
 export NODE_OPTIONS=--openssl-legacy-provider;
 export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath[
   pkgs.openssl
 ]};
 '';
        };
      });
}
