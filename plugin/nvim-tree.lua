local gh = require("utils.pack-helper").gh
vim.pack.add{
  gh("nvim-tree/nvim-web-devicons"),
  gh("nvim-tree/nvim-tree.lua")
}

local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local on_attach = function(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, silent = true, nowait = true }
  end
  -- default mappings
  api.map.on_attach.default(bufnr)
  -- custom mappings
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "o", api.node.open.tab, opts("Open in new Tab"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end


local config = {
  sort_by = "name",
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  renderer = {
    group_empty = true,
  },
  on_attach = on_attach
}

nvim_tree.setup(config)


vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<cr>", { silent = true })
