# """
#     h5dump(filename)

# Dumps the group/data tree of a HDF5 file.
# """
# function h5dump(filename::String, space::String="      ")
#   HDF5.h5open(filename, "r+") do f
#     h5dump_recursive(f["/"], space)
#   end
# end
# function h5dump_recursive(g::HDF5.HDF5Group, space::String, level::Int=0)
#     println(space ^ level, HDF5.name(g))
#     for el in HDF5.names(g)
#         if typeof(g[el]) == HDF5.HDF5Group
#             h5dump_recursive(g[el], space, level+1)
#         else
#           println(space ^ (level+1), el)
#         end
#    end
# end
# export h5dump