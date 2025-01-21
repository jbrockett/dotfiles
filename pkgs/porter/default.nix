{ lib, stdenv, fetchurl, version }:

let
  platforms = {
    x86_64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_amd64";
      sha256 = "cce69da069a282431712403b2bdddb296e1c8af29872cca99a603cf59417c93f";
    };
    aarch64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_arm64";
      sha256 = "68b2852edbb0377a9a8e70f1e30b362d615e5618c0bbc9550e44a212858ab997";
    };
    x86_64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_amd64";
      sha256 = "91c45b2bfec9408c851a241cbc4f77d9645e6c703448de0d24be345c7b7c6fcd";
    };
    aarch64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_arm64";
      sha256 = "c99eed8fbf66822d955d9f83d8242fa22c4acd02da781b0900e9eaac588b2a9e";
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
