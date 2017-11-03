
"""
**Helpers** is a collection of useful functions missing in base Julia.
GitHub Repository: [crstnbr/Helpers.jl](http://julialang.org/)
"""
module Helpers

include("math.jl")
include("hdf5.jl")
include("filesystem.jl")
include("profiling.jl")

"""
    setGLOBAL_RNG(rng)

Replaces current `Base.Random.GLOBAL_RNG` with `rng`.
"""
function setGLOBAL_RNG(rng::MersenneTwister)
  Base.Random.GLOBAL_RNG.idx = rng.idx
  Base.Random.GLOBAL_RNG.state = rng.state
  Base.Random.GLOBAL_RNG.vals = rng.vals
  Base.Random.GLOBAL_RNG.seed = rng.seed
  nothing
end

"""
    swap_rows!(X, i, j)

Swaps rows `i` and `j` of `X`.
"""
function swap_rows!(X, i, j)
    for k = 1:size(X,2)
        X[i,k], X[j,k] = X[j,k], X[i,k]
    end
end
export swap_rows!

"""
    swap_cols!(X, i, j)

Swaps cols `i` and `j` of `X`.
"""
function swap_cols!(X, i, j)
    for k = 1:size(X,2)
        X[k,i], X[k,j] = X[k,j], X[k,i]
    end
end
export swap_cols!

end # module


"""
    precompile_packages()

Trigger precompilation of all packages.
"""
function precompile_packages()
    excl = ["Helpers", "ErrorAnalysis", "Yoni"]
    for pkg in keys(Pkg.installed())
        if pkg in excl
            continue
        end

        try
            info("Compiling: $pkg")
            eval(Expr(:toplevel, Expr(:using, Symbol(pkg))))
        catch err
            warn("Unable to precompile: $pkg")
            warn(err)
        end
    end
end
export precompile_packages


"""
    upgrade(build=false)

Upgrade all installed Julia packages (i.e. update, [build], and precompile).
"""
function upgrade(build=false)
    Pkg.update();
    if build
        Pkg.build();
    end
    precompile_packages()
end
export upgrade