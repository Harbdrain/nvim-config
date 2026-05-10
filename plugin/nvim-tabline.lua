local gh = require("utils.pack-helper").gh
vim.pack.add {
  gh("nvim-tree/nvim-web-devicons"),
  gh("crispgm/nvim-tabline")
}

local ok, tabline = pcall(require, "tabline")
if not ok then
  return
end

tabline.setup({
  show_index = false,
  show_icon = true,
  brackets = { '', '' }
})
