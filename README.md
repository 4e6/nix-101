# Nix 101

https://nixos.org/nix/download.html

The quickest way to install it on Linux and Mac OS X is to run the following in a shell
(as a user other than root):

```
$ curl https://nixos.org/nix/install | sh
```

## Nix language

http://nixos.org/nix/manual/#ch-expression-language

+ Scalar
  - String  "foo"
  - Integer 42
  - Path    ./default.nix
  - Boolean true
  - null    null

+ List      [ "foo" 42 true ]

+ Set       { a = "foo"; b = 42; }
  aka attributes

  ```
  ({ a = "foo"; b = 42; }).b
  ```
  > 42

+ (mutually) Recursive set:
  rec { a = 42; b = a + 1; }

+ Let expression
  `let x = 1; y = 2; in x + y` # 3

  ```
    let
      x = 1
      y = 2
    in x + y
  ```
  > 3

+ Functions

  pattern: body

  ```
  let inc = x: x + 1
  in inc 42
  ```
  > 43

  ```
  let f = x: y: x + y
  in f 3 4
  ```
  > 7

  ```
  let g = { x, y }: x + y
  in f { x = 1; y = 2; }
  ```
  > 3

  `let g = { x, y ? 2 }: x + y; in f { x = 1; }`    # 3

  'inherit' and 'with'

  ```
    let
      g = { x, y }: x + y
      myObj = { x = 1; y = 2; }
      y = 2
    in
  ```
  ```
    g myObj
    g { x = myObj.x; y = myObj.y; }
    g { inherit (myObj) x y; }
    g { x = 1; inherit y; }
    with myObj; g { inherit x y; }
  ```
  > 3

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
