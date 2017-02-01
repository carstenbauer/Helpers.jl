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
function absdiff(A::Array{Complex{Float64},2}, B::Array{Complex{Float64},2})
  return abs(A-B)
end
export absdiff