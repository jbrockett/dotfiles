{ lib, stdenv, fetchurl, version, eksctl }:

let
  platforms = {
    x86_64-linux = {
      url = "https://github.com/awslabs/eksdemo/releases/download/v${version}/eksdemo_Linux_x86_64.tar.gz";
      sha256 = "7ffb46604032d4b2ee09b1633af69fba1c5fd7f0aeba7f4898c13bb487127d7d";
    };
    aarch64-linux = {
      url = "https://github.com/awslabs/eksdemo/releases/download/v${version}/eksdemo_Linux_arm64.tar.gz";
      sha256 = "6ff0591e7984eb57dafa70c47949f13d0844237bcbec62ac9ac4bea24868f9fe";
    };
    x86_64-darwin = {
      url = "https://github.com/awslabs/eksdemo/releases/download/v${version}/eksdemo_Darwin_x86_64.tar.gz";
      sha256 = "115be7050fe8d678af7822e9eae8a670988e3817512db5b6b4ad168e478d5f72";
    };
    aarch64-darwin = {
      url = "https://github.com/awslabs/eksdemo/releases/download/v${version}/eksdemo_Darwin_arm64.tar.gz";
      sha256 = "6d13ee1f608a989c1ee0d47cf15f3de2fa182ce1ebfec7bf3509a042bdfe0347";
    };
  };

  platform = platforms.${stdenv.hostPlatform.system} or (throw "Unsupported platform");
in
stdenv.mkDerivation {
  pname = "eksdemo";
  inherit version;

  propagatedBuildInputs = [ eksctl ];

  src = let
    url = platform.url;
  in builtins.trace "Attempting to fetch eksdemo from: ${url}" (fetchurl {
    inherit (platform) url sha256;
  });

  installPhase = ''
    mkdir -p $out/bin
    cp eksdemo $out/bin/eksdemo
    chmod +x $out/bin/eksdemo
    
    # Install completions
    install -Dm644 completions/eksdemo.bash $out/share/bash-completion/completions/eksdemo
    install -Dm644 completions/eksdemo.zsh $out/share/zsh/site-functions/_eksdemo
    install -Dm644 completions/eksdemo.fish $out/share/fish/vendor_completions.d/eksdemo.fish
  '';

  meta = with lib; {
    description = "The easy button for learning, testing and demoing Amazon EKS";
    homepage = "https://github.com/awslabs/eksdemo";
    license = licenses.mit;
    platforms = builtins.attrNames platforms;
  };
}
