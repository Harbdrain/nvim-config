local gh = require("utils.pack-helper").gh
vim.pack.add{ gh("mason-org/mason.nvim") }

local ok, mason = pcall(require, "mason")
if not ok then
  return
end

mason.setup()
