using Documenter, Helpers

makedocs(
    # options
    
)

makedocs(
    modules = [Helpers],
    format = :html,
    sitename = "Helpers.jl",
    pages = [
        "Home" => "index.md",
        "Functions" => "functions.md"
        # "Subsection" => [
        #     ...
        # ]
    ]
)

deploydocs(
    repo   = "github.com/crstnbr/Helpers.jl.git",
    target = "build",
    deps   = nothing,
    make   = nothing,
    julia  = "release",
    osname = "linux"
)