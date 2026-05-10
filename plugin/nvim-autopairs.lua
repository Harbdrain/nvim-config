local gh = require("utils.pack-helper").gh
vim.pack.add{ gh("windwp/nvim-autopairs") }

local ok, nvim_autopairs = pcall(require, "nvim-autopairs")
if not ok then
  return
end

nvim_autopairs.setup{
  check_ts = true,
  enable_check_bracket_line = false,
}
