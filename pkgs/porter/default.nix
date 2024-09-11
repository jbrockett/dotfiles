{ lib, stdenv, fetchurl }:

let
  version = "0.55.8";
  system = stdenv.hostPlatform.system;
  url = {
    "x86_64-linux" = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_amd64";
    "aarch64-linux" = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_arm64";
    "x86_64-darwin" = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_amd64";
    "aarch64-darwin" = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_arm64";
  }.${system} or (throw "Unsupported system: ${system}");
  sha256 = {
    "x86_64-linux" = "5d9810c41a3364742c73772c4f424f147f588e4a1b0e067f1fcd0b5e6a57129c";
    "aarch64-linux" = "03ee271d5205fac20dd9759ba477a81fd31fa23db2aab41526030ae6ee16360a";
    "x86_64-darwin" = "e8660f5284c516a2c156e3bff4491bf35ef1f2266625b86e2738eea1666098ae";
    "aarch64-darwin" = "a2aa08a0d4ce068b9590e176be908834d9ae4e113c92e26821aa38d096a6ada1";
  }.${system} or (throw "Unsupported system: ${system}");
in
stdenv.mkDerivation {
  pname = "porter";
  inherit version;

  src = fetchurl {
    inherit url sha256;
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/porter
    chmod +x $out/bin/porter
  '';

  meta = with lib; {
    description = "Deploy your applications into your own cloud account";
    homepage = "https://github.com/porter-dev/porter";
    license = licenses.mit;
    platforms = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
  };
}
