local gh = require("utils.pack-helper").gh
vim.pack.add{
  {
    src = gh("vague-theme/vague.nvim"),
--    version = vim.version.range("*")
  }
}

local ok, vague = pcall(require, "vague")
if not ok then
  return
end

vague.setup{
  on_highlights = function(hl, colors)
    hl.TabLineSel = { fg = colors.comment, bg = colors.fg }
  end
}
