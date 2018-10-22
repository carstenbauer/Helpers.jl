"""
    setrng(rng)

Replaces current `Random.GLOBAL_RNG` with `rng`.
"""
function setrng(rng::MersenneTwister)
  Random.GLOBAL_RNG.idx = rng.idx
  Random.GLOBAL_RNG.state = rng.state
  Random.GLOBAL_RNG.vals = rng.vals
  Random.GLOBAL_RNG.seed = rng.seed
  nothing
end
export setrng

"""
    swaprows!(X, i, j)

Swaps rows `i` and `j` of `X`.
"""
function swaprows!(X::AbstractMatrix, i::Integer, j::Integer)
    for k = 1:size(X,2)
        X[i,k], X[j,k] = X[j,k], X[i,k]
    end
end
export swaprows!

"""
    swapcols!(X, i, j)

Swaps cols `i` and `j` of `X`.
"""
function swapcols!(X::AbstractMatrix, i::Integer, j::Integer)
    for k = 1:size(X,2)
        X[k,i], X[k,j] = X[k,j], X[k,i]
    end
end
export swapcols!


"""
    extension(filepath::AbstractString)

Extracts lowercase file extension from given filepath.
Extension is defined as "everything after the last dot".
"""
function extension(filepath::AbstractString)
    filename = basename(filepath)
    return lowercase(filename[end-something(findfirst(isequal('.'), reverse(filename)), 0)+2:end])
end
export extension
#export alias fileext as well


"""
Macro to define substitute macros.

Concretely, `@def mymacro body` will define a macro
such that `@mymacro` will be replaced by `body`.
"""
macro def(name, definition)
    return quote
        macro $(esc(name))()
            esc($(Expr(:quote, definition)))
        end
    end
end
export @def