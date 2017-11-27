import HDF5

"""
    h5dump(filename)

Dumps the group/data tree of a HDF5 file.
"""
h5dump(f::HDF5.HDF5File, space::String="      ") = h5dump_recursive(f["/"], space)

function h5dump(filename::String, space::String="      ")
  HDF5.h5open(filename, "r+") do f
    h5dump(f,space)
  end
end
function h5dump_recursive(g::HDF5.HDF5Group, space::String, level::Int=0)
    println(space ^ level, HDF5.name(g))
    for el in HDF5.names(g)
        if typeof(g[el]) == HDF5.HDF5Group
            h5dump_recursive(g[el], space, level+1)
        else
          println(space ^ (level+1), el)
        end
   end
end
export h5dump

"""
    h5delete(filename, element)

Deletes a group or dataset from a HDF5 file. However, due to the HDF5 standard
it might be that space is not freed.
"""
function h5delete(filename::String, el::String)
  HDF5.h5open(filename, "r+") do f
    if !HDF5.exists(f, el)
        error("Element \"$el\" does not exist in \"$filename\".")
    end
    HDF5.o_delete(f, el)
  end
  nothing
end
export h5delete

"""
    h5repack(src, trg)

Repacks a HDF5 file e.g. to free unused space. If `src == trg`Wrapper to external h5repack
application.
"""
function h5repack(src::String, trg::String)
    if src == trg   h5repack(src)  end
    @static if is_windows()
        readstring(`h5repack.exe $src $trg`)
    end
    @static if is_linux()
        readstring(`h5repack $src $trg`)
    end
end
function h5repack(filename::String)
    h5repack(filename, "tmp.h5")
    mv("tmp.h5",filename,remove_destination=true)
end
export h5repack
