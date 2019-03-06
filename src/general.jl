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
    @inbounds for k = 1:size(X,2)
        X[i,k], X[j,k] = X[j,k], X[i,k]
    end
end
export swaprows!

"""
    swapcols!(X, i, j)

Swaps cols `i` and `j` of `X`.
"""
function swapcols!(X::AbstractMatrix, i::Integer, j::Integer)
    @inbounds for k = 1:size(X,1)
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





"""
    meshgrid(xvec) = meshgrid(xvec, xvec)

Produces a 2D meshgrid `X,X` by repeating xvec in y-dimension and xvec in x-dimension.
"""
meshgrid(v::AbstractVector{T}) where T<:Number = meshgrid(v, v)

"""
    meshgrid(xvec, yvec)

Produces a 2D meshgrid `X,Y` by repeating xvec in y-dimension and yvec in x-dimension.
"""
function meshgrid(vx::AbstractVector{T}, vy::AbstractVector{S}) where T<:Number where S<:Number
    m, n = length(vy), length(vx)
    vx = reshape(vx, 1, n)
    vy = reshape(vy, m, 1)
    (repeat(vx, m, 1), repeat(vy, 1, n))
end

"""
    meshgrid(xvec, yvec, yvec)

Produces a 3D meshgrid `X,Y,Z` by repeating the input vectors.
"""
function meshgrid(vx::AbstractVector{T}, vy::AbstractVector{S}, vz::AbstractVector{R}) where T<:Number where S<:Number where R<:Number
    m, n, o = length(vy), length(vx), length(vz)
    vx = reshape(vx, 1, n, 1)
    vy = reshape(vy, m, 1, 1)
    vz = reshape(vz, 1, 1, o)
    om = ones(Int, m)
    on = ones(Int, n)
    oo = ones(Int, o)
    (vx[om, :, oo], vy[:, on, oo], vz[om, on, :])
end
export meshgrid