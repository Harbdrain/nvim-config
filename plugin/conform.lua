local gh = require("utils.pack-helper").gh
vim.pack.add{ gh("stevearc/conform.nvim") }

local ok, conform = pcall(require, "conform")
if not ok then
  return
end

conform.formatters.shfmt = {
  append_args = { "-i", "4", "-ci" }
}

conform.setup{
  formatters_by_ft = {
    sh = { "shfmt" },
    python = { "black" }
  }
}
