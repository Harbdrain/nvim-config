local gh = require("utils.pack-helper").gh
vim.pack.add{ gh("nvim-mini/mini.surround") }

local ok, mini_surround = pcall(require, "mini.surround")
if not ok then
  return
end

mini_surround.setup{
  mappings = {
    add = '<leader>sa',
    delete = '<leader>sd',
    find = '<leader>sf',
    find_left = '<leader>sF',
    highlight = '<leader>sh',
    replace = '<leader>sr',
    update_n_lines = '<leader>sn',
  }
}
