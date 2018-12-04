"""
    setrng(rng)

Replaces current `Random.GLOBAL_RNG` with `rng`.
"""
function setrng(rng::MersenneTwister)
  Random.GLOBAL_RNG.idxI = rng.idxI
  Random.GLOBAL_RNG.idxF = rng.idxF
  Random.GLOBAL_RNG.state = rng.state
  Random.GLOBAL_RNG.vals = rng.vals
  Random.GLOBAL_RNG.seed = rng.seed
  Random.GLOBAL_RNG.ints = rng.ints
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


"""
  merge_project_tomls(out, A, B)

Merge two Project.toml files `A` and `B` into `out` (overwriting `out`).
"""
function merge_project_tomls(out, A, B)
    a = readdlm(A)
    b = readdlm(B)
    pa = Dict{String, String}((a[i,1], a[i,3]) for i in axes(a, 1))
    pb = Dict{String, String}((b[i,1], b[i,3]) for i in axes(b, 1))
    p = sort(merge(pa, pb))

    s = "[deps]\n"
    for (k, v) in p
        k == "[deps]" && continue
        s = join((s, k, " = ", "\"", v, "\"", "\n"))
    end
    write(out, s)
    nothing
end
export merge_project_tomls