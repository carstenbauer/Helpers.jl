
"""
**Helpers** is a collection of useful functions missing in base Julia.
GitHub Repository: [crstnbr/Helpers.jl](http://julialang.org/)
"""
module Helpers

include("math.jl")

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

end # module
