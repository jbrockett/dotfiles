Use the following steps to get started using Nix and this configuration:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install macos  #The macos arguement was recently required to avoid encrypting the nix volume when filevault is already enabled.
git clone https://github.com/jbrockett/dotfiles.git
nix build github:jbrockett/dotfiles#homeConfigurations.jeremy.activationPackage
result/activate
home-manager switch --flake github:jbrockett/dotfiles#jeremy 
```

**Other useful commands:**

To upgrade all packages:

```bash
nix flake update
home-manager switch --flake .#jeremy
```

**To clean up old derivations:**

```bash
home-manager generations
home-manager remove-generations [generation ids]
```

**To cleanup unused files:**

```bash
nix-collect-garbage -d
```
