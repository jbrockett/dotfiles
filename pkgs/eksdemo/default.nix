{ buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "eksdemo-v0.13.0";

  goPackagePath = "github.com/awslabs/eksdemo";

  subPackages = [ "." ];

  src = fetchFromGitHub {
    owner = "awslabs";
    repo = "eksdemo";
    rev = "v0.13.0";
    sha256 = "286d581c56d78dce586055e1f0236e9ec62e231aa2f58c7454e2d09a14b26135";
  };

  # goDeps = ./deps.nix;
}