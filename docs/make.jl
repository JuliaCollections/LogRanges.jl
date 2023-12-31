using LogRanges
using Documenter

DocMeta.setdocmeta!(LogRanges, :DocTestSetup, :(using LogRanges); recursive=true)

makedocs(;
    modules=[LogRanges],
    authors="Michael Abbott, Lilith Orion Hafner <lilithhafner@gmail.com>, and contributors",
    repo="https://github.com/JuliaCollections/LogRanges.jl/blob/{commit}{path}#{line}",
    sitename="LogRanges.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaCollections.github.io/LogRanges.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaCollections/LogRanges.jl",
    devbranch="main",
)
