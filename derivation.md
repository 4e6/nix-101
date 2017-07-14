# Derivation

From Nix Manual [Part IV. Writing Nix Expressions][writing-nix-expressions]:

> Building something from other stuff is called a derivation in Nix (as opposed
> to sources, which are built by humans instead of computers)

In other words, derivation is a function that "build something", i.e. a Nix
package or an environment (collection of packages) given some inputs ("from
other stuff").

Nix function that "buld something" is called `mkDerivation`.

> `mkDerivation` wraps the builtin `derivation` function to
> produce derivations that use this stdenv and its shell.
>
> See also:
>
> * https://nixos.org/nixpkgs/manual/#sec-using-stdenv
>   Details on how to use this mkDerivation function
>
> * https://nixos.org/nix/manual/#ssec-derivation
>   Explanation about derivations in general


Derivation of GNU hello application:

``` nix
{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "hello-2.10";

  src = fetchurl {
    url = "mirror://gnu/hello/${name}.tar.gz";
    sha256 = "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i";
  };

  meta = {
    description = "A program that produces a familiar, friendly greeting";
    longDescription = ''
      GNU Hello is a program that prints "Hello, world!" when you run it.
      It is fully customizable.
    '';
    homepage = http://www.gnu.org/software/hello/manual/;
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = [ stdenv.lib.maintainers.eelco ];
    platforms = stdenv.lib.platforms.all;
  };
}
```

It is a function, that takes a set with two attributes: `stdenv` and `fetchurl`
and calls `stdenv.mkDerivation`. `mkDerivation` takes recursive set of
attributes `rec { ... }` and creates another set, an input for a builder.

TODO: write about builder process and builder attribute of `mkDerivation`

[writing-nix-expressions]: https://nixos.org/nix/manual/#chap-writing-nix-expressions
