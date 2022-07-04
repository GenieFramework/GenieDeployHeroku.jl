module GenieDeployHeroku

import Genie
import GenieDeploy

const HEROKU = @static Sys.iswindows() ? `heroku.cmd` : `heroku`

"""
    apps()

Returns list of apps available on Heroku account.
"""
function apps() :: Nothing
  `$HEROKU apps` |> GenieDeploy.run

  nothing
end

"""
    createapp(appname::String; region::String = "us")

Runs the `heroku create` command to create a new app in the indicated region.
See https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-create-app
"""
function createapp(appname::String; region::String = "us", stack::Union{String,Symbol,Nothing} = :container) :: Nothing
  `$HEROKU create $(appname) --region $region` |> GenieDeploy.run
  stack !== nothing && setstack(appname, stack)

  nothing
end


"""
    stack(appname::String)

Determine which stack your app is using and list available stacks.
"""
function stack(appname::String) :: Nothing
  `$HEROKU stack -a $(appname)` |> GenieDeploy.run

  nothing
end


"""
    setstack(appname::String, stack::Union{String,Symbol})

Change the stack your app will use for the next deploy. Default stack is `container`.
See `stack(appname)` for available stacks.
"""
function setstack(appname::String, stack::Union{String,Symbol} = :container) :: Nothing
  `$HEROKU stack:set $(stack) -a $(appname)` |> GenieDeploy.run

  nothing
end


"""
    push(appname::String; apptype::String = "web")

Invokes the `heroku container:push` which builds, then pushes Docker images to deploy your Heroku app.
See https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-push
"""
function push(appname::String; apptype::String = "web") :: Nothing
  `$HEROKU container:push $apptype -a $appname` |> GenieDeploy.run

  nothing
end


"""
    release(appname::String; apptype::String = "web")

Invokes the `keroku container:release` which releases previously pushed Docker images to your Heroku app.
See https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-push
"""
function release(appname::String; apptype::String = "web") :: Nothing
  `$HEROKU container:release $apptype -a $appname` |> GenieDeploy.run

  nothing
end


"""
    open(appname::String)

Invokes the `heroku open` command which open the app in a web browser.
See https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-open-path
"""
function open(appname::String) :: Nothing
  `$HEROKU open -a $appname` |> GenieDeploy.run

  nothing
end


"""
    login()

Invokes the `heroku container:login` to log in to Heroku Container Registry,
See https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-login
"""
function login() :: Nothing
  `$HEROKU container:login` |> GenieDeploy.run

  nothing
end


"""
    logs(appname::String; lines::Int = 1_000)

Display recent heroku log output.
https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-logs
"""
function logs(appname::String; lines::Int = 1_000) :: Nothing
  `$HEROKU logs --tail -a $appname -n $lines` |> GenieDeploy.run

  nothing
end

end
