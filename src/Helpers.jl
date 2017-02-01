
"""
**Helpers** is a collection of useful functions missing in base Julia.
GitHub Repository: [crstnbr/Helpers.jl](http://julialang.org/)
"""
module Helpers

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
    sparsity(A)

Calculates the sparsity of the given array.
The sparsity is defined as number of zero-valued elements divided by
total number of elements.
"""
function sparsity(A::AbstractArray)
  length(findin(A,0))/length(A)
end
export sparsity

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
    reldiff(A, B)

Relative difference of absolute values of `A` and `B` defined as

``
\\operatorname{reldiff} = 2 \\dfrac{\\operatorname{abs}(A - B)}{\\operatorname{abs}(A+B)}.
``
"""
function reldiff(A::AbstractArray, B::AbstractArray)
  return 2*abs(A-B)./abs(A+B)
end
export reldiff

"""
    absdiff(A, B)

Difference of absolute values of `A` and `B`.
"""
function absdiff(A::Array{Complex{Float64},2}, B::Array{Complex{Float64},2})
  return abs(A-B)
end
export absdiff

end # module
