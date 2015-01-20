--- template manipulation.
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- @license MIT (see @{LICENSE})
-- @module templates

local M = {}

--- writes a line to the file selected.
-- @param loc location of the file.
-- @param file to write to.
-- @param str to write.
-- @param m optional mode for file to write. Defaults to "a+" if left empty.
function M:write_line(loc, file, str, m)
  io.open(loc .. "/" .. file, m or "a+"):write(str):close()
end

--- copies the templates to their destination.
-- @param loc see @{write_line| loc}.
-- @param templates a table containing the name of the template files.
-- @param src the source location of the builder.
function M:copy(loc, templates, src)
  for _, template in ipairs(templates) do
    local ftemplate = io.open(loc .. "/" .. template, "w")
    for line in io.open(src .. "/templates/" .. template):lines() do
      ftemplate:write(line, "\n")
    end
    ftemplate:close()
  end
end


return M
