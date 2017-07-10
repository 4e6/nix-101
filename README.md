# Nix 101

Nix 101 is a collection of Nix recipes to be able to work with Nix
effectively. Each chapter contains some info on a particular topic of Nix
infrastructure.

## Derivation

http://nixos.org/nix/manual/#sec-expression-syntax

http://nixos.org/nix/manual/#ssec-derivation

Derivation - a set of _specific_ attributes for Builder

Builder - a _pure_ function from attributes to directory

## Applications

+ Nixpkgs
  A set of derivations for common software tools

+ Nix
  Package (derivations) manager

  Terms:
  - User
  - Profile
  - Generation

  http://nixos.org/nix/manual/#sec-profiles

  + `nix-env --list generations`
  + `nix-env --install`
  + `nix-env --upgrade`
  + `nix-env --rollback`

+ NixOS

  Build root directory (/) from derivation.

+ NixOps + Disnix

  Manage multiple NixOS machines.

  http://nixos.org/nixops/

  http://nixos.org/disnix/

+ Build Docker image

  - directory
  - docker config (json)

  http://nixos.org/nixpkgs/manual/#sec-pkgs-dockerTools


# Nix recipes

## Derivations

http://nixos.org/nixpkgs/manual/#sec-stdenv-phases

```
nix-build -K -A hello ./hello.nix
```

## Haskell infrastructure

http://nixos.org/nixpkgs/manual/#users-guide-to-the-haskell-infrastructure

### discover packages

`nix-env -f '<nixpkgs>' -qaP -A haskellPackages`

### structure

```
<nixpkgs>
  - haskellPackages = haskell.packages.ghc802
  - haskell
    - compiler
      - ghc7103
      - ghc801
      - ...
    - packages
      - ghc7103
      - ghc801
      ...
```

discover packages in `nix-repl`

`nix-env -i nix-repl`
`nix-shell -p nix-repl --command nix-repl`

```
nix-repl> nixpkgs = import <nixpkgs> {}

nix-repl> nixpkgs.haskell.packages
{ ghc6123 = { ... }; ghc704 = { ... }; ghc7102 = { ... }; ghc7103 = { ... }; ghc722 = { ... }; ghc742 = { ... }; ghc763 = { ... }; ghc783 = { ... }; ghc784 = { ... }; ghc801 = { ... }; ghc802 = { ... }; ghc821 = { ... }; ghcCross = { ... }; ghcCross821 = { ... }; ghcHEAD = { ... }; ghcHaLVM240 = { ... }; ghcjs = { ... }; ghcjsHEAD = { ... }; integer-simple = { ... }; }
``
