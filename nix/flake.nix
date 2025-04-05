{
  description = "A startup basic project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    devshell.url = "github:numtide/devshell";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devshell.flakeModule
      ];

      perSystem = { pkgs, ... }: {
        devshells.default = {
          packages = with pkgs; [
            (fennel-ls.overrideAttrs (_: rec {
              version = "latest";
              src = pkgs.fetchFromSourcehut {
                owner = "~xerool";
                repo = "fennel-ls";
                rev = "b7984ca5";
                hash = "sha256-QYqzalnpVkTjOocJrVcOf2kUzruZCDSj2T4WZiPBmOM=";
              };
              nativeBuildInputs = [ pkgs.pandoc ];
            }))
          ];
        };
      };

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    };
}
