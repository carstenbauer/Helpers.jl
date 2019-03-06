"""
    sparsity(A)

Calculates the sparsity of the given array.
The sparsity is the number of zero-valued elements over the
total number of elements.
"""
sparsity(A::AbstractArray{<:Number}) = count(iszero, A)/length(A)
export sparsity

"""
    reldiff(A, B)

Relative difference of absolute values of `A` and `B` defined as

``
\\operatorname{reldiff} = 2 \\dfrac{\\operatorname{abs}(A - B)}{\\operatorname{abs}(A+B)}.
``
"""
function reldiff(A::AbstractArray{T}, B::AbstractArray{S}) where T<:Number where S<:Number
  return 2*abs.(A-B)./abs.(A+B)
end
export reldiff


"""
    effreldiff(A, B, threshold=1e-14)

Same as `reldiff(A,B)` but with all elements set to zero where corresponding element of
`absdiff(A,B)` is smaller than `threshold`. This is useful in avoiding artificially large
relative errors.
"""
function effreldiff(A::AbstractArray{T}, B::AbstractArray{S}, threshold::Float64=1e-14) where T<:Number where S<:Number
  r = reldiff(A,B)
  r[findall(x->abs.(x)<threshold,absdiff(A,B))] .= 0.
  return r
end
export effreldiff


"""
    absdiff(A, B)

Difference of absolute values of `A` and `B`.
"""
function absdiff(A::AbstractArray{T}, B::AbstractArray{S}) where T<:Number where S<:Number
  return abs.(A-B)
end
export absdiff


"""
    compare(A, B)

Compares two matrices `A` and `B`, prints out the maximal absolute and relative differences
and returns a boolean indicating wether `isapprox(A,B)`.
"""
function compare(A::AbstractArray{T}, B::AbstractArray{S}) where T<:Number where S<:Number
  @printf("max absdiff: %.1e\n", maximum(absdiff(A,B)))
  @printf("mean absdiff: %.1e\n", mean(absdiff(A,B)))
  @printf("max reldiff: %.1e\n", maximum(reldiff(A,B)))
  @printf("mean reldiff: %.1e\n", mean(reldiff(A,B)))

  r = effreldiff(A,B)
  @printf("effective max reldiff: %.1e\n", maximum(r))
  @printf("effective mean reldiff: %.1e\n", mean(r))

  return isapprox(A,B)
end
export compare


"""
    compare_full(A, B)

Compares two matrices `A` and `B`, prints out all absolute and relative differences
and returns a boolean indicating wether `isapprox(A,B)`.
"""
function compare_full(A::AbstractArray{T}, B::AbstractArray{S}) where T<:Number where S<:Number
  compare(A,B)
  println("")
  println("absdiff: ")
  display(absdiff(A,B))
  println("")
  println("reldiff: ")
  display(reldiff(A,B))
  println("")
  return isapprox(A,B)
end
export compare_full


"""
    comm(A, B)

Commutator `AB - BA`.
"""
function comm(A::AbstractArray{T}, B::AbstractArray{S}) where T<:Number where S<:Number
  return A*B - B*A
end
export comm


"""
    docommute(A, B)

Checks if the matrices do (approx.) commute.
"""
function docommute(A::AbstractArray{T}, B::AbstractArray{S}) where T<:Number where S<:Number
  return isapprox(comm(A,B),zeros(size(A)...))
end
export docommute


# import PyCall: PyObject
# PYCALL_LOADED = false

# """
#     sparsejl2py(X)

# Convert julia sparse matrix to python (scipy csc) sparse matrix.
# """
# function sparsejl2py(S::SparseMatrixCSC)
#   if !PYCALL_LOADED
#     eval(Expr(:toplevel, Expr(:using, Symbol("PyCall"))))
#     eval(Expr(:toplevel, parse("@pyimport scipy.sparse as pysparse")))
#   end
#   pysparse.csc_matrix((S.nzval, S.rowval .- 1, S.colptr .- 1), shape=size(S))
# end
# export sparsejl2py

# """
#     sparsepy2jl(X)

# Convert python sparse matrix to julia sparse matrix.
# """
# sparsepy2jl(S::PyObject) =
#     SparseMatrixCSC(S[:m], S[:n], S[:indptr] .+ 1, S[:indices] .+ 1, S[:data])
# export sparsepy2jl


"""
    sparsejl2py(X)

Convert julia sparse matrix to python (scipy csc) sparse matrix.
"""
function sparsejl2py(S::SparseMatrixCSC)
  @eval using PyCall
  # eval(Expr(:toplevel, Expr(:using, Symbol("PyCall"))))
  # eval(Expr(:toplevel, parse("@pyimport scipy.sparse as pysparse")))
  @eval @pyimport scipy.sparse as pysparse
  pysparse.csc_matrix((S.nzval, S.rowval .- 1, S.colptr .- 1), shape=size(S))
end
export sparsejl2py

"""
    sparsepy2jl(X::PyObject)

Convert python sparse matrix to julia sparse matrix.
"""
sparsepy2jl(S) =
    SparseMatrixCSC(S[:m], S[:n], S[:indptr] .+ 1, S[:indices] .+ 1, S[:data])
export sparsepy2jl