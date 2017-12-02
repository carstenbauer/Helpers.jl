# Documentation

This package my a personal collection of convenience functions that I find useful in my daily work with Julia. If you want, it is a highly subjective extension of base Julia. Typically functions are added when I work on physics simulations, in particular my Determinant Quantum Monte Carlo (DQMC) code, and think "why isn't there an inbuild function for this?". However, the functions in [`Helpers.jl`](https://github.com/crstnbr/Helpers.jl) are generic while I keep specific functions, like Monte Carlo error estimators, in other packages like e.g. [`ErrorAnalysis.jl`](https://github.com/crstnbr/Helpers.jl).


## Installation

To install the package execute the following command in the REPL:
```julia
Pkg.clone("https://github.com/crstnbr/Helpers.jl")
```

Afterwards, you can use `Helpers.jl` like any other package installed with `Pkg.add()`:
```julia
using Helpers
```

To obtain the latest version of the package just do `Pkg.update()` or specifically `Pkg.update("Helpers")`.

