module GenieDeployHeroku

import Genie
import GenieDeploy

const HEROKU = @static Sys.iswindows() ? `heroku.cmd` : `heroku`

"""
    apps()

Returns list of apps available on Heroku account.
"""
function apps()
  `$HEROKU apps` |> GenieDeploy.run
end

"""
    createapp(appname::String; region::String = "us")

Runs the `heroku create` command to create a new app in the indicated region.
See https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-create-app
"""
function createapp(appname::String; region::String = "us")
  `$HEROKU create $(appname) --region $region` |> GenieDeploy.run
end


"""
    push(appname::String; apptype::String = "web")

Invokes the `heroku container:push` which builds, then pushes Docker images to deploy your Heroku app.
See https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-push
"""
function push(appname::String; apptype::String = "web")
  `$HEROKU container:push $apptype -a $appname` |> GenieDeploy.run
end


"""
    release(appname::String; apptype::String = "web")

Invokes the `keroku container:release` which releases previously pushed Docker images to your Heroku app.
See https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-push
"""
function release(appname::String; apptype::String = "web")
  `$HEROKU container:release $apptype -a $appname` |> GenieDeploy.run
end


"""
    open(appname::String)

Invokes the `heroku open` command which open the app in a web browser.
See https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-open-path
"""
function open(appname::String)
  `$HEROKU open -a $appname` |> GenieDeploy.run
end


"""
    login()

Invokes the `heroku container:login` to log in to Heroku Container Registry,
See https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-login
"""
function login()
  `$HEROKU container:login` |> GenieDeploy.run
end


"""
    logs(appname::String; lines::Int = 1_000)

Display recent heroku log output.
https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-logs
"""
function logs(appname::String; lines::Int = 1_000)
  `$HEROKU logs --tail -a $appname -n $lines` |> GenieDeploy.run
end

end
