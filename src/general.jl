"""
    setrng(rng)

Replaces current `Base.Random.GLOBAL_RNG` with `rng`.
"""
function setrng(rng::MersenneTwister)
  Base.Random.GLOBAL_RNG.idx = rng.idx
  Base.Random.GLOBAL_RNG.state = rng.state
  Base.Random.GLOBAL_RNG.vals = rng.vals
  Base.Random.GLOBAL_RNG.seed = rng.seed
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


const MOST_USED_PKGS = ["HDF5", "JLD", "PyPlot", "Distributions", "IJulia",
     "DataFrames", "LsqFit", "Polynomials", "BenchmarkTools", "NPZ", "ProfileView",
     "LaTeXStrings", "StatsBase", "Git", "LightXML", "Iterators", "CSV"]

"""
    precompile_packages(;all=false)

Trigger precompilation of most used (or [all]) packages.
"""
function precompile_packages(; all=false)
    excl = ["Helpers", "ErrorAnalysis", "Yoni"]
    for pkg in keys(Pkg.installed())
        if pkg in excl
            continue
        end

        if !all && !(pkg in MOST_USED_PKGS)
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
    upgrade(;build=false, all=false)

Upgrade most used (or [all]) installed Julia packages (i.e. update, [build], and precompile).
"""
function upgrade(; build=false, all=false)
    Pkg.update();
    if build
        Pkg.build();
    end
    precompile_packages(all=all)
end
export upgrade


"""
    install_most_used_pkgs()

Upgrade all installed Julia packages (i.e. update, [build], and precompile).
"""
function install_most_used_pkgs()
    for pkg in MOST_USED_PKGS
        try
            info("Installing: $pkg")
            Pkg.add(pkg)
        catch err
            warn("Unable to install: $pkg")
            warn(err)
        end
    end
end
export install_most_used_pkgs


"""
    extension(filepath::AbstractString)

Extracts lowercase file extension from given filepath.
Extension is defined as "everything after the last dot".
"""
function extension(filepath::AbstractString)
    filename = basename(filepath)
    return lowercase(filename[end-search(reverse(filename), '.')+2:end])
end
export extension

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