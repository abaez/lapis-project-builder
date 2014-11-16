#!/usr/bin/lua
---  lapis initilization builder with custom settings.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @license MIT (see @{README.md.LICENSE|LICENSE})
-- @module lapis_init

local help = [=[
    lapis_init v0.5
    usage: lapis_init <name> [-p <path>] [-d]

    Available actions:
    [name]      name of the lapis project
    -p <path>   the location of the installation for the project.
    -d <path>   makes the docker container. Needs docker-lapis path.
    -h          prints this text

]=]


--- appends volume location fig.yml.
-- @function make_fig
-- @param loc location of the lapis project.
function make_fig(loc)
    fa = io.open(loc .. "/fig.yml", "a+")
    fa:write("\tvolumes:\n")
    fa:write("\t\t- " .. loc .. ":/server")
    fa:close()
end

--- creates the docker container for lapis.
-- @function build_docker
-- @param loc the location of the docker-lapis local copy.
function build_docker(loc)
    loc = loc or "/data/Projects/self/docker-lapis"
    os.execute("cd " .. loc .. "; docker build -t abaez/lapis .")
end

--- creates the intialized directory for the lapis project.
-- @function build_env
-- @param loc location of the lapis project path.
-- @param template the mercurial repository to use as a template.
function build_env(loc, template)
    template = template or "/data/Projects/self/lapis-template"
    os.execute(string.format("hg clone %s %s", template, loc))
    os.execute("echo '' > " .. loc .. '/.hg/hgrc')
    make_fig(loc)
end

--- simple delay timer.
-- @function wait
function wait()
    local t = os.time() + 3
    while os.time() < t  do
    end
end

if #arg == 0 or arg[1] == "-h" then
    print(help)
else
    if #arg > 1 then
        for i = 2, #arg do
            if arg[i] == '-d' then
                print("building docker container")
                wait()
                build_docker()
            elseif arg[i] == '-p' then
                print("making environment build")
                wait()
                build_env(arg[i+1] .. "/" .. arg[1])
            end
        end
    else
        assert(arg[1] ~= '-d' and arg[1] ~= '-p', help)
        print("making environment project: " .. arg[1])
        wait()
        build_env(string.format("%s/%s", io.popen("pwd"):read(), arg[1]))
    end
end
