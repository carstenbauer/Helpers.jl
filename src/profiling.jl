# function profile_save(fname::String="profile.bin")
#     f = open(fname, "w")
#     serialize(f, Profile.retrieve())
#     close(f)
# end
# export profile_save

# PROFILEVIEW_USEGTK = true
# using ProfileView
# function profile_view(fname::String="profile.bin")
#     f = open(fname)
#     r = deserialize(f);
#     ProfileView.view(r[1], lidict=r[2])
#     println("done")
#     close(f)
# end
# export profile_view