{ lib, stdenv, fetchurl, version }:

let
  platforms = {
    x86_64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_amd64";
      sha256 = "d83b40554651cca473bf574a8722e4062a9d7189b255a721b29bb3fb09998189";
    };
    aarch64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_arm64";
      sha256 = "9ff38541335b117541945f75e5e1887273bf60b8c016524193cad9901c697d1c";
    };
    x86_64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_amd64";
      sha256 = "095a55f3349c9adc5933f0881ff617a70a6a235ff6bb87a0634b047cd1151eb5";
    };
    aarch64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_arm64";
      sha256 = "887ebb74b377483c8cb1a6377eeed53a38e586b4609535c705cadd8e92dd7977";
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
