{ lib, stdenv, fetchurl, version }:

let
  platforms = {
    x86_64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_amd64";
      sha256 = "efabdb993611aebba251ed12911faa8e47269655a760caaec7f3d0314d91bc99";
    };
    aarch64-linux = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_linux_arm64";
      sha256 = "5f9847432c7f79a3706eddcf7db877e9bc5b99161641d4f07aacf98f04999182";
    };
    x86_64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_amd64";
      sha256 = "404a61b749d037eec6aa50ee388877778dd7fb72ee02a654c23bf435f8cd2311";
    };
    aarch64-darwin = {
      url = "https://github.com/porter-dev/releases/releases/download/v${version}/porter_${version}_darwin_arm64";
      sha256 = "fc492aed126b172fb5dc410275d6872676bbc5ab3bc3c4472dc1687487285f98";
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
    platforms = builtins.attrNames platforms;
  };
}
