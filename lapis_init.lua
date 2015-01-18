#!/usr/bin/lua
---  lapis initilization builder with custom settings.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @license MIT (see @{README.md.LICENSE|LICENSE})
-- @module lapis_init

local _CONF = io.popen("echo $HOME"):read() .. "/.lapis_init.conf"

--- gives the string for the specified vcs.
-- @param vcs choose which DVCS to use. If 'git' not given, then auto to 'hg'.
function vcs_str(vcs)
  return vcs == 'git' and
    "git init; git add -A; git commit -m 'initial commit'" or
    "hg init; hg commit -Am 'initial commit'"
end

--- writes a line to the file selected.
-- @function write_line
-- @param dest location of the file.
-- @param file to write to.
-- @param str to write.
-- @param m optional mode for file to write. Defaults to "a+" if left empty.
function write_line(dest, file, str, m)
  io.open(dest .. "/" .. file, m or "a+"):write(str):close()
end

--- makes the config file for love_init
-- @param file the absolute location of default configuration file.
-- @param src see @{src}.
local function make_conf(file, src)
  print("making the file: " .. file)
  local finit = io.open(file, "w")
  for line in io.open(src .."/templates/lapis_init.conf"):lines() do
    finit:write(line, "\n")
  end
  finit:close()

  print("Please change src correctly in:", file)
  os.exit()
end

--- gets the user configuration file.
-- @param file see @{file}.
-- @param src see @{src}.
local function get_user(file, src)
  local user = ""
  if not io.open(file) then
    assert(src, "run with [-s <source>] argument")
    make_conf(file, src)
  else
    user = dofile(file, "t")
    assert(user.src, "Edit src: '" .. file .. "' to run")
  end

  return user
end

--- creates the docker container for lapis from abaez/docker-lapis.
-- @param cont the docker-lapis source location.
local function build_docker(cont)
  os.execute("cd " .. cont .. "; docker build -t abaez/lapis .")
end

--- creates the intialized directory for the lapis project.
-- @function build_env
-- @param dest location of the project directory.
-- @param name the name love project path.
-- @param src the source path of lapis project builder.
-- @param cont see @{build_docker| cont}.
-- @param user see @{user}.
-- @param vcs see @{vcs_str| vcs}.
function build_env(dest, name, src, cont, user, vcs)
  assert(os.execute("mkdir " .. dest), "Couldn't make: " .. dest)

  os.execute("cd " .. loc .. ";" .. vcs_str(vcs))
end

--- simple delay timer.
function wait(time)
  local time = time or os.time() + 3; while os.time() < time  do end
end

--- a temporary table for command run.
-- @param cwd holds the current working directory of lapis_init.
local tmp = {
  vcs       = false, -- see @{vcs_str| vcs}.
  src       = false, -- see @{conf.user| user}
  name      = false, -- see @{build_env| name}
  dest      = false, -- see @{build_env| dest}
  cont      = false, -- see @{build_docker| cont}
  cwd       = io.popen("pwd"):read() .. "/"
}

local help = [=[
  lapis_init v1.0
  usage: lapis_init <name> [Options]

  <name>      name of the lapis project.

  Options:
  -d <path>   makes the docker container. Needs docker-lapis path.
  -g          use 'git' to instead of 'hg'. Automates to 'hg' if not given.
  -p <path>   the location for the project to be made.
  -s <src>    the location of lapis-project-builder source.
  -h          prints this text

]=]

if #arg == 0 or arg[1] == '-h' then
  print(help)
elseif arg[1] == '-s' then
  get_user(_CONF, arg[2])
else
  assert(arg[1] ~= '-d' and arg[1] ~= '-p', help)
  tmp.name = arg[1]

  if #arg > 1 then
    for i = 2, #arg do
      if arg[i] == '-p' then
        tmp.dest = arg[i+1] .. "/" .. tmp.name
      elseif arg[i]  == '-s' then
        tmp.src = arg[i+1]
      elseif arg[i] == 'd'then
        tmp.cont = arg[i+1]
      elseif arg[i] == '-g' then
        tmp.vcs = 'git'
      end
    end

    print("making environment project: " .. tmp.name)
    build_env(
      tmp.dest or tmp.cwd .. tmp.name,
      tmp.name,
      tmp.src,
      tmp.cont,
      get_user(_CONF, tmp.src),
      tmp.vcs)
  else
    print("making environment project: " .. tmp.name)
    build_env(tmp.cwd .. tmp.name,
              tmp.name,
              tmp.src,
              tmp.cont,
              get_user(_CONF, tmp.src),
              tmp.vcs)
  end
end
