{ lib, stdenv, fetchurl, version }:

let
  platforms = {
    x86_64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_amd64";
      sha256 = "e1d30ba4931cdd4b387e2f6d1d15caec6e7cf421b4c212fbcb0e1fee3090aaa1";
    };
    aarch64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_arm64";
      sha256 = "37e4bcf5587deff395a7ce4c94404b070ff2eda38cfe34c2625d4e9860135390";
    };
    x86_64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_amd64";
      sha256 = "e20c1bcc09cf1aea0ca6b73e6a12d7116950e98708b7395fc01a31e541613848";
    };
    aarch64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_arm64";
      sha256 = "ccf0f4c3c33ee49594c5591c461f28c9970b7908b515ad4a2ca4b768a004a643";
    };
  };

  platform = platforms.${stdenv.hostPlatform.system} or (throw "Unsupported platform");
in
stdenv.mkDerivation rec {
  pname = "porter";
  inherit version;

  src = fetchurl {
    inherit (platform) url sha256;
  };

  sourceRoot = ".";
  dontUnpack = true;
  dontBuild = true;
  dontStrip = true;
  dontPatchELF = true;

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    cp $src $out/bin/porter
    chmod +x $out/bin/porter
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "Deploy your applications into your own cloud account";
    homepage = "https://github.com/porter-dev/porter";
    license = licenses.mit;
    platforms = builtins.attrNames platforms;
  };
}
