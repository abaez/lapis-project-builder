#!/usr/bin/lua
---  lapis initilization builder with custom settings.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @license MIT (see @{README.md.LICENSE|LICENSE})
-- @module lapis_init

--- default configurations for lapis_init.
-- @table conf
-- @field lpb the lapis-project-builder location.
-- @field dl the docker-lapis location.
local conf = {
    lpb = "/data/Projects/self/lapis-project-builder",
    dl = "/data/Projects/self/docker-lapis"
}

local help = [=[
    lapis_init v0.8
    usage: lapis_init <name> [-p <path>] [-d <path>]

    Available actions:
    <name>      name of the lapis project
    -p <path>   the location of the installation for the project.
    -d <path>   makes the docker container. Needs docker-lapis path.
    -h          prints this text

]=]


--- writes a line to the file selected.
-- @function write_line
-- @param loc location of the file.
-- @param file to write to.
-- @param str to write.
-- @param m optional mode for file to write. Defaults to "a+" if left empty.
function write_line(loc, file, str, m)
    io.open(loc .. "/" .. file, m or "a+"):write(str):close()
end

--- creates the docker container for lapis.
-- @function build_docker
-- @param loc the location of the docker-lapis local copy.
function build_docker(loc)
    local loc = loc or conf.dl
    os.execute("cd " .. loc .. "; docker build -t abaez/lapis .")
end

--- checks lpb for new updates.
-- @function has_update
function has_update()
    for line in io.popen("cd  " .. conf.lpb .. "; hg incoming"):lines() do
        if line:match("no changes found") then
          return false
        end
    end

    return true
end

--- creates the intialized directory for the lapis project.
-- @function build_env
-- @param loc location of the lapis project path.
-- @param template the mercurial repository to use as a project template.
function build_env(loc, template)
    local template = template or conf.lpb
    os.execute(string.format("hg clone %s %s", template, loc))
    os.remove(loc .. "/lapis_init.lua")
    os.remove(loc .. "/README.md")
    write_line(loc, "config.ld", string.format("project = %q", arg[1]))
    write_line(loc, "fig.yml", "  volumes:\n    - " .. loc .. ":/server")
    os.execute("rm -rf " .. loc .. "/.hg")
    os.execute("cd " .. loc ..
               "; hg init; hg add; hg commit -m 'initial commit'")
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
                assert(not has_update(), "You need to update lpb")
                build_env(arg[i+1] .. "/" .. arg[1])
            end
        end
    else
        assert(not has_update(), "You need to update lpb")
        assert(arg[1] ~= '-d' and arg[1] ~= '-p', help)
        print("making environment project: " .. arg[1])
        wait()
        build_env(string.format("%s/%s", io.popen("pwd"):read(), arg[1]))
    end
end
