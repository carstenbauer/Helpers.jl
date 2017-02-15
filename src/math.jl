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
function absdiff(A::AbstractArray, B::AbstractArray)
  return abs(A-B)
end
export absdiff


"""
    compare(A, B)

Compares two matrices `A` and `B`, prints out the maximal absolute and relative differences
and returns a boolean indicating wether `isapprox(A,B)`.
"""
function compare(A::AbstractArray, B::AbstractArray)
  @printf("max absdiff: %.1e\n", maximum(absdiff(A,B)))
  @printf("mean absdiff: %.1e\n", mean(absdiff(A,B)))
  @printf("max reldiff: %.1e\n", maximum(reldiff(A,B)))
  @printf("mean reldiff: %.1e\n", mean(reldiff(A,B)))
  return isapprox(A,B)
end
export compare


"""
    compare_full(A, B)

Compares two matrices `A` and `B`, prints out all absolute and relative differences
and returns a boolean indicating wether `isapprox(A,B)`.
"""
function compare_full(A::AbstractArray, B::AbstractArray)
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
function comm(A::AbstractArray, B::AbstractArray)
  return A*B - B*A
end
export comm


"""
    docommute(A, B)

Checks if the matrices do (approx.) commute.
"""
function docommute(A::AbstractArray, B::AbstractArray)
  return isapprox(comm(A,B),zeros(size(A)...))
end
export docommute