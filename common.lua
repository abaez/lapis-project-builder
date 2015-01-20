--- common used functions.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @license MIT (see @{LICENSE})
-- @module common

local M = {}

--- gives the string for the specified vcs.
-- @param vcs choose which DVCS to use. If 'git' not given, then auto to 'hg'.
function M.vcs_str(vcs)
  return vcs == 'git' and
    "git init; git add -A; git commit -m 'initial commit'" or
    "hg init; hg commit -Am 'initial commit'"
end

--- simple delay timer.
-- @param time the amount of seconds to wait for run.
function M.wait(time)
  local time = time or os.time() + 3; while os.time() < time  do end
end

return M
