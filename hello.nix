{ nixpkgs ? import <nixpkgs> {} }:

import <nixpkgs/pkgs/applications/misc/hello> { inherit (nixpkgs) stdenv fetchurl; }
