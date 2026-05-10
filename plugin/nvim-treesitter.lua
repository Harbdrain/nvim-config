local parsers = { "java", "javadoc", "lua", "luadoc", "luap", "bash", "python", "comment", "regex", "json", "desktop", "printf", "readline", "html", "markdown_inline", "vim", "vimdoc", "query", "toml" }

local hooks = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
    if not ev.data.active then
      vim.cmd.packadd("nvim-treesitter")
    end
    vim.cmd("TSUpdate")
  end
end
local pack_changed_group = vim.api.nvim_create_augroup("PostPackHook", {
  clear = false
})
vim.api.nvim_create_autocmd("PackChanged", { group = pack_changed_group, callback = hooks })

local gh = require("utils.pack-helper").gh
vim.pack.add{ gh("nvim-treesitter/nvim-treesitter") }


local ok, nvim_treesitter = pcall(require, "nvim-treesitter")
if not ok then
  return
end

nvim_treesitter.install(parsers)

local installedParsers = nvim_treesitter.get_installed("parsers")

local treesitterStart = vim.api.nvim_create_augroup("treesitter-start-files", {})
for _, parser in ipairs(installedParsers) do
  local filetypes = vim.treesitter.language.get_filetypes(parser)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = treesitterStart,
    pattern = filetypes,
    callback = function()
      vim.treesitter.start()
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = 'expr'
      vim.wo[0][0].foldlevel = 20
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end
