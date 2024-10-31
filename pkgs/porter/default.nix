{ lib, stdenv, fetchurl, version }:

let
  platforms = {
    x86_64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_amd64";
      sha256 = "7ffb46604032d4b2ee09b1633af69fba1c5fd7f0aeba7f4898c13bb487127d7d";
    };
    aarch64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_arm64";
      sha256 = "6ff0591e7984eb57dafa70c47949f13d0844237bcbec62ac9ac4bea24868f9fe";
    };
    x86_64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_amd64";
      sha256 = "115be7050fe8d678af7822e9eae8a670988e3817512db5b6b4ad168e478d5f72";
    };
    aarch64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_arm64";
      sha256 = "6d13ee1f608a989c1ee0d47cf15f3de2fa182ce1ebfec7bf3509a042bdfe0347";
    };
  };

  platform = platforms.${stdenv.hostPlatform.system} or (throw "Unsupported platform");
in
stdenv.mkDerivation {
  pname = "porter";
  inherit version;

  src = let
    url = platform.url;
  in builtins.trace "Attempting to fetch Porter from: ${url}" (fetchurl {
    inherit (platform) url sha256;
  });

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
