# Nix language

This is a quick introduction on basic constructions of the Nix language. For
other sources you can check the links in the footer.

## Scalar

- String  `"foo"`
- Integer `42`
- Path    `./default.nix`
- Boolean `true`
- null    `null`

## List

`[ "foo" 42 true ]`

> [ "foo" 42 true ]

## Set

A set of key-value pairs is called a _set_, or sometimes _attributes_, or
_attribute set_.

`{ a = "foo"; b = 42; }`

> { a = "foo"; b = 42; }

Each key-value entity is called _attribute_`, i.e `b = 42;` is _an attribute_.

## Mutually recursive Set

When attributes reference each other, this relation should be marked explicitly
with keyword `rec`

`rec { a = 42; b = a / 2; }`

> { a = 42; b = 21; }

Set can be accessed by key with a dot (`.`)

`{ a = "foo"; b = 42; }.a`

> "foo"

## Keyword `inherit`

Keyword brings into current scope of a set given attributes. Tthus it can be used only inside a
curly braces notation.

`{ inherit (path) attr1 attr2 ...; }`

For example, given

`myObj = { x = 1; y = 2; }`

expression

``` nix
{ inherit (myObj) x y; }
```

> { x = 1; y = 2; }

is equivalent to

``` nix
{ x = myObj.x; y = myObj.y }
```

> { x = 1; y = 2; }

And given

``` nix
y = 2
```

expression

``` nix
{ inherit y; x = 1; }
```

> { x = 1; y = 2 }

is equivalent to

``` nix
{ y = y; x = 1; }
```

> { x = 1; y = 2; }

## Keyword `with`

Keyword `with set` brings attributes of a `set` into the current scope.

For example, given

``` nix
myObj = { x = 1; y = 2; }
```

``` nix
with myObj; x
```

> 1

``` nix
with myObj; { inherit x y }
```

> { x = 1; y = 2 }

## Let expression

`let x = 1; y = 2; in x + y`

> 3

## Function

Nix support lambdas of the form `pattern: body`. Named lambda can be assigned to
a variable.

``` nix
let inc = x: x + 1
in inc 7
```

> 8

Lambdas support currying.

``` nix
let f = x: y: x + y
in f 3 4
```

> 7

Function `g` below expects set with attributes `x` and `y`. This notation is
called _set pattern_ (in other languages it is sometimes called _destructuring_,
i.e. we pattern-match on the structure of set.

``` nix
let g = { x, y }: x + y
in g { x = 1; y = 2; }
```

> 3

_Set pattern_ supports attributes with default values.

``` nix
let g = { x, y ? 2 }: x + y
in g { x = 1; }
```

> 3

# Literature

+ Nix manual chapter [Nix expression language](http://nixos.org/nix/manual/#ch-expression-language)
+ Learn X in Y minutes [where X = Nix](https://learnxinyminutes.com/docs/nix/)
