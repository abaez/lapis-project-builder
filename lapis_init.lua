#!/usr/bin/lua
---  lapis initilization builder with custom settings.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @license MIT (see @{README.md.LICENSE|LICENSE})
-- @module lapis_init

local _CONF = io.popen("echo $HOME"):read() .. "/.lapis_init.conf"

local common = false
local templates = false
local user = false

--- loads module files from src.
-- @param file the configuration file.
-- @param src see @{user}.
local function load_mod(file, src)
  package.path = (src or dofile(file).src) .. "/?.lua;" .. package.path
  common = require("common")
  templates = require("templates")
  user = require("user")
end

--- creates the docker container for lapis from abaez/docker-lapis.
-- @param cont the docker-lapis source location.
local function build_docker(cont)
  os.execute("cd " .. cont .. "; docker build -t abaez/lapis .")
end

--- appends from template with basic settings.
-- @param dest see @{build_env| dest}.
-- @param name see @{build_env| name}.
local function append_files(dest, name)
  templates:write_line(dest, "config.ld", string.format(
    "project = %q\ntitle = %q", name, name .. " docs"))
  templates:write_line(dest, "fig.yml",
    "  volumes:\n    - " .. dest .. ":/server")
end

--- creates the intialized directory for the lapis project.
-- @function build_env
-- @param dest location of the project directory.
-- @param name the name love project path.
-- @param src the source path of lapis project builder.
-- @param cont see @{build_docker| cont}.
-- @param user see @{conf.user| user}.
-- @param vcs see @{vcs_str| vcs}.
function build_env(dest, name, src, cont, user, vcs)
  assert(os.execute("mkdir " .. dest), "Couldn't make: " .. dest)
  templates:copy(dest, user.templates, src or user.src)
  append_files(dest, name)

  os.execute("cd " .. dest .. ";" .. common.vcs_str(vcs))
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
  require("user"):get(_CONF, arg[2])
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

    load_mod(_CONF, tmp.src)
    print("making environment project: " .. tmp.name)
    build_env(
      tmp.dest or tmp.cwd .. tmp.name,
      tmp.name,
      tmp.src,
      tmp.cont,
      user:get(_CONF, tmp.src),
      tmp.vcs)
  else
    load_mod(_CONF, tmp.src)
    print("making environment project: " .. tmp.name)
    build_env(tmp.cwd .. tmp.name,
              tmp.name,
              tmp.src,
              tmp.cont,
              user:get(_CONF, tmp.src),
              tmp.vcs)
  end
end
