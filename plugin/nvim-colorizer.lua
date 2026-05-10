local gh = require("utils.pack-helper").gh
vim.pack.add{ gh("catgoose/nvim-colorizer.lua") }

local ok, colorizer = pcall(require, "colorizer")
if not ok then
  return
end

colorizer.setup{
  user_default_options = {
    names = false,
    RRGGBBAA = true
  },
  filetypes = {
    "*",
    css = {
      names = true,
      rgb_fn = true,
      hsl_fn = true
    }
  }
}
