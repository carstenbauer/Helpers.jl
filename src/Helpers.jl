"""
**Helpers** is a collection of useful functions missing in base Julia.
GitHub Repository: [crstnbr/Helpers.jl](http://julialang.org/)
"""
module Helpers

#stdlibs
using Random, Printf, Statistics

#external pkgs
import HDF5
using JLD

include("general.jl")
include("math.jl")
include("hdf5.jl")
include("profiling.jl")

end # module