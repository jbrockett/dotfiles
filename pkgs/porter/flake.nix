{
  description = "Porter - Deploy your applications into your own cloud account";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      version = "0.55.8";
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          url = if system == "x86_64-linux" then
                  "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_amd64"
                else if system == "aarch64-linux" then
                  "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_arm64"
                else if system == "x86_64-darwin" then
                  "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_amd64"
                else if system == "aarch64-darwin" then
                  "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_arm64"
                else
                  throw "Unsupported system: ${system}";
          sha256 = if system == "x86_64-linux" then
                     "5d9810c41a3364742c73772c4f424f147f588e4a1b0e067f1fcd0b5e6a57129c"
                   else if system == "aarch64-linux" then
                     "03ee271d5205fac20dd9759ba477a81fd31fa23db2aab41526030ae6ee16360a"
                   else if system == "x86_64-darwin" then
                     "e8660f5284c516a2c156e3bff4491bf35ef1f2266625b86e2738eea1666098ae"
                   else if system == "aarch64-darwin" then
                     "a2aa08a0d4ce068b9590e176be908834d9ae4e113c92e26821aa38d096a6ada1"
                   else
                     throw "Unsupported system: ${system}";
        in
        {
          default = pkgs.stdenv.mkDerivation {
            pname = "porter";
            inherit version;
            src = pkgs.fetchurl {
              inherit url sha256;
            };
            dontUnpack = true;
            installPhase = ''
              mkdir -p $out/bin
              cp $src $out/bin/porter
              chmod +x $out/bin/porter
            '';
          };
        }
      );

      # Define default package for each system
      defaultPackage = forAllSystems (system: self.packages.${system}.default);
    };
}
