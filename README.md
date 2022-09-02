# dkml-runtime-apps

This repository is meant for DKML contributors.

## Building

> You can do with following commands in Windows Diskuv OCaml
> preceding with `with-dkml bash`:

```console
$ make switch

$ # Optional
$ make ide

$ # Only needed if you are changing Opam dependencies.
$ # Will not work on Windows yet until pins or patches submitted to Opam Monorepo
$ make duniverse
```

## Opam Monorepo

The `with-dkml` project and its dependency `dkml-runtimelib` have Opam Monorepo files:
* `with-dkml.opam.locked`
* `dkml-runtimelib.opam.locked`
* `duniverse/`

The purpose of Opam Monorepo for `with-dkml` is so that `dune.2.9.3+shim.1.0.1` and the other Dune
shims can build `with-dkml.exe` _while_ building simultaneously building Dune. All we have to do is to check in
`duniverse/` and with a slight modification to Dune's `opam` file we can bundle `with-dkml.exe`
as a shim.

You can use:
* `opam install ./dkml-runtimelib.opam ./with-dkml.opam --locked` to install the Opam Monorepo version of `with-dkml`
* `opam install ./dkml-runtimelib.opam ./with-dkml.opam` to install the regular Opam version of `with-dkml`
* `make duniverse` to update the Dune universe `duniverse/`

You will need to do the following to **build** using the Dune universe without any Opam dependencies:
1. uncomment `(dirs :standard \ duniverse)` in the toplevel `dune` (or temporarily remove the toplevel `dune` file) and
2. run `dune build --display=short -p with-dkml,dkml-runtimelib`