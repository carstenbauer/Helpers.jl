var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#Documentation-1",
    "page": "Home",
    "title": "Documentation",
    "category": "section",
    "text": "This package my a personal collection of convenience functions that I find useful in my daily work with Julia. If you want, it is a highly subjective extension of base Julia. Typically functions are added when I work on physics simulations, in particular my Determinant Quantum Monte Carlo (DQMC) code, and think \"why isn't there an inbuild function for this?\". However, the functions in Helpers.jl are generic while I keep specific functions, like Monte Carlo error estimators, in other packages like e.g. ErrorAnalysis.jl."
},

{
    "location": "index.html#Installation-1",
    "page": "Home",
    "title": "Installation",
    "category": "section",
    "text": "To install the package execute the following command in the REPL:Pkg.clone(\"https://github.com/crstnbr/Helpers.jl\")Afterwards, you can use Helpers.jl like any other package installed with Pkg.add():using HelpersTo obtain the latest version of the package just do Pkg.update() or specifically Pkg.update(\"Helpers\")."
},

{
    "location": "functions.html#",
    "page": "Functions",
    "title": "Functions",
    "category": "page",
    "text": ""
},

{
    "location": "functions.html#Functions-1",
    "page": "Functions",
    "title": "Functions",
    "category": "section",
    "text": "Below you will find all methods exported by Helpers.jl."
},

{
    "location": "functions.html#Index-1",
    "page": "Functions",
    "title": "Index",
    "category": "section",
    "text": ""
},

{
    "location": "functions.html#Helpers.absdiff-Tuple{AbstractArray,AbstractArray}",
    "page": "Functions",
    "title": "Helpers.absdiff",
    "category": "Method",
    "text": "absdiff(A, B)\n\nDifference of absolute values of A and B.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.comm-Tuple{AbstractArray,AbstractArray}",
    "page": "Functions",
    "title": "Helpers.comm",
    "category": "Method",
    "text": "comm(A, B)\n\nCommutator AB - BA.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.compare-Tuple{AbstractArray,AbstractArray}",
    "page": "Functions",
    "title": "Helpers.compare",
    "category": "Method",
    "text": "compare(A, B)\n\nCompares two matrices A and B, prints out the maximal absolute and relative differences and returns a boolean indicating wether isapprox(A,B).\n\n\n\n"
},

{
    "location": "functions.html#Helpers.compare_full-Tuple{AbstractArray,AbstractArray}",
    "page": "Functions",
    "title": "Helpers.compare_full",
    "category": "Method",
    "text": "compare_full(A, B)\n\nCompares two matrices A and B, prints out all absolute and relative differences and returns a boolean indicating wether isapprox(A,B).\n\n\n\n"
},

{
    "location": "functions.html#Helpers.docommute-Tuple{AbstractArray,AbstractArray}",
    "page": "Functions",
    "title": "Helpers.docommute",
    "category": "Method",
    "text": "docommute(A, B)\n\nChecks if the matrices do (approx.) commute.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.effreldiff",
    "page": "Functions",
    "title": "Helpers.effreldiff",
    "category": "Function",
    "text": "effreldiff(A, B, threshold=1e-14)\n\nSame as reldiff(A,B) but with all elements set to zero where corresponding element of absdiff(A,B) is smaller than threshold. This is useful in avoiding artificially large relative errors.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.h5delete-Tuple{String,String}",
    "page": "Functions",
    "title": "Helpers.h5delete",
    "category": "Method",
    "text": "h5delete(filename, element)\n\nDeletes a group or dataset from a HDF5 file. However, due to the HDF5 standard it might be that space is not freed.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.h5dump",
    "page": "Functions",
    "title": "Helpers.h5dump",
    "category": "Function",
    "text": "h5dump(filename)\n\nDumps the group/data tree of a HDF5 file.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.h5repack-Tuple{String,String}",
    "page": "Functions",
    "title": "Helpers.h5repack",
    "category": "Method",
    "text": "h5repack(src, trg)\n\nRepacks a HDF5 file e.g. to free unused space. If src == trgWrapper to external h5repack application.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.loadrng-Tuple{HDF5.HDF5File}",
    "page": "Functions",
    "title": "Helpers.loadrng",
    "category": "Method",
    "text": "loadrng(filename [; group=\"GLOBAL_RNG\"]) -> MersenneTwister   loadrng(f::HDF5.HDF5File [; group=\"GLOBAL_RNG\"]) -> MersenneTwister\n\nLoads a random generator from HDF5.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.meshgrid-Tuple{AbstractArray{T,1} where T}",
    "page": "Functions",
    "title": "Helpers.meshgrid",
    "category": "Method",
    "text": "meshgrid(xvec) = meshgrid(xvec, xvec)\n\nProduces a 2D meshgrid X,X by repeating xvec in y-dimension and xvec in x-dimension.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.meshgrid-Union{Tuple{AbstractArray{T,1},AbstractArray{T,1},AbstractArray{T,1}}, Tuple{T}} where T",
    "page": "Functions",
    "title": "Helpers.meshgrid",
    "category": "Method",
    "text": "meshgrid(xvec, yvec, yvec)\n\nProduces a 3D meshgrid X,Y,Z by repeating the input vectors.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.meshgrid-Union{Tuple{AbstractArray{T,1},AbstractArray{T,1}}, Tuple{T}} where T",
    "page": "Functions",
    "title": "Helpers.meshgrid",
    "category": "Method",
    "text": "meshgrid(xvec, yvec)\n\nProduces a 2D meshgrid X,Y by repeating xvec in y-dimension and yvec in x-dimension.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.reldiff-Tuple{AbstractArray,AbstractArray}",
    "page": "Functions",
    "title": "Helpers.reldiff",
    "category": "Method",
    "text": "reldiff(A, B)\n\nRelative difference of absolute values of A and B defined as\n\noperatornamereldiff = 2 dfracoperatornameabs(A - B)operatornameabs(A+B)\n\n\n\n"
},

{
    "location": "functions.html#Helpers.restorerng-Tuple{String}",
    "page": "Functions",
    "title": "Helpers.restorerng",
    "category": "Method",
    "text": "restorerng(filename [; group=\"GLOBAL_RNG\"]) -> Void   restorerng(f::HDF5.HDF5File [; group=\"GLOBAL_RNG\"]) -> Void\n\nRestores a state of Julia's random generator (Base.Random.GLOBAL_RNG) from HDF5.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.saverng",
    "page": "Functions",
    "title": "Helpers.saverng",
    "category": "Function",
    "text": "saverng(filename [, rng::MersenneTwister; group=\"GLOBAL_RNG\"])   saverng(HDF5.HDF5File [, rng::MersenneTwister; group=\"GLOBAL_RNG\"])\n\nSaves the current state of Julia's random generator (Base.Random.GLOBAL_RNG) to HDF5.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.setrng-Tuple{MersenneTwister}",
    "page": "Functions",
    "title": "Helpers.setrng",
    "category": "Method",
    "text": "setrng(rng)\n\nReplaces current Base.Random.GLOBAL_RNG with rng.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.sparsejl2py-Tuple{SparseMatrixCSC}",
    "page": "Functions",
    "title": "Helpers.sparsejl2py",
    "category": "Method",
    "text": "sparsejl2py(X)\n\nConvert julia sparse matrix to python (scipy csc) sparse matrix.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.sparsepy2jl-Tuple{PyCall.PyObject}",
    "page": "Functions",
    "title": "Helpers.sparsepy2jl",
    "category": "Method",
    "text": "sparsepy2jl(X)\n\nConvert python sparse matrix to julia sparse matrix.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.sparsity-Tuple{AbstractArray}",
    "page": "Functions",
    "title": "Helpers.sparsity",
    "category": "Method",
    "text": "sparsity(A)\n\nCalculates the sparsity of the given array. The sparsity is defined as number of zero-valued elements divided by total number of elements.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.swapcols!-Tuple{AbstractArray{T,2} where T,Integer,Integer}",
    "page": "Functions",
    "title": "Helpers.swapcols!",
    "category": "Method",
    "text": "swapcols!(X, i, j)\n\nSwaps cols i and j of X.\n\n\n\n"
},

{
    "location": "functions.html#Helpers.swaprows!-Tuple{AbstractArray{T,2} where T,Integer,Integer}",
    "page": "Functions",
    "title": "Helpers.swaprows!",
    "category": "Method",
    "text": "swaprows!(X, i, j)\n\nSwaps rows i and j of X.\n\n\n\n"
},

{
    "location": "functions.html#Docs-1",
    "page": "Functions",
    "title": "Docs",
    "category": "section",
    "text": "Modules = [Helpers]\nPrivate = false\nOrder   = [:function, :type]"
},

]}
