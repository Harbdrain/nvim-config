local gh = require("utils.pack-helper").gh
vim.pack.add{ gh("nvim-treesitter/nvim-treesitter-textobjects") }

local ok, nvim_treesitter_textobjects = pcall(require, "nvim-treesitter-textobjects")
if not ok then
  return
end

nvim_treesitter_textobjects.setup{
  select = {
    lookahead = true,

    selection_modes = {
      ["@function.outer"] = "V",
      ["@class.outer"] = "V",
    },
    include_surrounding_whitespace = false,
  }
}

vim.keymap.set({ "x", "o" }, "am",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "im",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ac",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ic",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end)
