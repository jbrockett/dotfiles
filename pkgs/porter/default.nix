{ lib, stdenv, fetchurl }:

let
  pname = "porter";
  version = "0.55.8";
  baseUrl = "https://github.com/porter-dev/releases/releases/download/v${version}";

  sources = {
    x86_64-darwin = fetchurl {
      url = "${baseUrl}/porter_${version}_darwin_amd64";
      sha256 = "e8660f5284c516a2c156e3bff4491bf35ef1f2266625b86e2738eea1666098ae";
    };
    aarch64-darwin = fetchurl {
      url = "${baseUrl}/porter_${version}_darwin_arm64";
      sha256 = "a2aa08a0d4ce068b9590e176be908834d9ae4e113c92e26821aa38d096a6ada1";
    };
    x86_64-linux = fetchurl {
      url = "${baseUrl}/porter_${version}_linux_amd64";
      sha256 = "5d9810c41a3364742c73772c4f424f147f588e4a1b0e067f1fcd0b5e6a57129c";
    };
    aarch64-linux = fetchurl {
      url = "${baseUrl}/porter_${version}_linux_arm64";
      sha256 = "03ee271d5205fac20dd9759ba477a81fd31fa23db2aab41526030ae6ee16360a";
    };
  };
in
stdenv.mkDerivation {
  inherit pname version;

  src = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/porter
    chmod +x $out/bin/porter
  '';

  meta = with lib; {
    description = "Deploy your applications into your own cloud account";
    homepage = "https://porter.run";
    license = licenses.unfree; # Assuming it's proprietary since the license isn't specified
    platforms = builtins.attrNames sources;
    maintainers = with maintainers; [ ]; # Add maintainers if known
  };
}
