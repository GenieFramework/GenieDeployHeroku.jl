using Documenter

push!(LOAD_PATH,  "../../src")

using GenieDeployHeroku

makedocs(
    sitename = "GenieDeployHeroku - Deploying Genie Apps to Heroku",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Home" => "index.md",
        "GenieDeployHeroku API" => [
          "GenieDeployHeroku" => "API/geniedeployheroku.md",
        ]
    ],
)

deploydocs(
  repo = "github.com/GenieFramework/GenieDeployHeroku.jl.git",
)
