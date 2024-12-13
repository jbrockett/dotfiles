{ lib, stdenv, fetchurl, version }:

let
  platforms = {
    x86_64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_amd64";
      sha256 = "9b933261939d37c36cbc0d25ded3dfa23b64b85bf1f3063fd5133dc34975f0b8";
    };
    aarch64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_arm64";
      sha256 = "35f46544999044307248fef85947ca034d2428044bc15298e5b35c531f7b9ab0";
    };
    x86_64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_amd64";
      sha256 = "0220f41dc6138840c6c2f59a49017b80aa882da9c98c6fbddfc913e373fae99a";
    };
    aarch64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_arm64";
      sha256 = "84e622fa4291eb0251a54bd9025361fb6085a8eadd893221ad91ff092375ca18";
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
