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


"""
  saverng(filename [, rng::MersenneTwister; group="GLOBAL_RNG"])
  saverng(HDF5.HDF5File [, rng::MersenneTwister; group="GLOBAL_RNG"])

Saves the current state of Julia's random generator (`Base.Random.GLOBAL_RNG`) to HDF5.
"""
function saverng(f::HDF5.HDF5File, rng::MersenneTwister=Base.Random.GLOBAL_RNG; group::String="GLOBAL_RNG")
  g = endswith(group, "/") ? group : group * "/"
  try
    if HDF5.exists(f, g)
      HDF5.o_delete(f, g)
    end

    f[g*"idx"] = rng.idx
    f[g*"state_val"] = rng.state.val
    f[g*"vals"] = rng.vals
    f[g*"seed"] = rng.seed
  catch e
    error("Error while saving RNG state: ", e)
  end
  nothing
end
function saverng(filename::String, rng::MersenneTwister=Base.Random.GLOBAL_RNG; group::String="GLOBAL_RNG")
  mode = isfile(filename) ? "r+" : "w"
  HDF5.h5open(filename, mode) do f
    saverng(f, rng; group=group)
  end
end
export saverng

"""
  loadrng(filename [; group="GLOBAL_RNG"]) -> MersenneTwister
  loadrng(f::HDF5.HDF5File [; group="GLOBAL_RNG"]) -> MersenneTwister

Loads a random generator from HDF5.
"""
function loadrng(f::HDF5.HDF5File; group::String="GLOBAL_RNG")::MersenneTwister
  rng = MersenneTwister(0)
  g = endswith(group, "/") ? group : group * "/"
  try
    rng.idx = read(f[g*"idx"])
    rng.state = Base.dSFMT.DSFMT_state(read(f[g*"state_val"]))
    rng.vals = read(f[g*"vals"])
    rng.seed = read(f[g*"seed"])
  catch e
    error("Error while restoring RNG state: ", e)
  end
  return rng
end
function loadrng(filename::String; group::String="GLOBAL_RNG")
  HDF5.h5open(filename, "r") do f
    loadrng(f; group=group)
  end
end
export loadrng

"""
  restorerng(filename [; group="GLOBAL_RNG"]) -> Void
  restorerng(f::HDF5.HDF5File [; group="GLOBAL_RNG"]) -> Void

Restores a state of Julia's random generator (`Base.Random.GLOBAL_RNG`) from HDF5.
"""
function restorerng(filename::String; group::String="GLOBAL_RNG")
  HDF5.h5open(filename, "r") do f
    restorerng(f; group=group)
  end
  nothing
end
restorerng(f::HDF5.HDF5File; group::String="GLOBAL_RNG") = setrng(loadrng(f; group=group))
export restorerng