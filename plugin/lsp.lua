local server_list = {
  "lua_ls",
  "jdtls",
  "bashls",
  "pyright",
  "jsonls",
  "vtsls",
  "tombi"
}
-- jdtls in ftplugin/java.lua

local gh = require("utils.pack-helper").gh
vim.pack.add{ gh("neovim/nvim-lspconfig") }

vim.diagnostic.config{
  update_in_insert = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.ERROR] = ""
    }
  },
  virtual_text = {
    current_line = true
  }
}

local opts = { silent = true }

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local buf_id = ev.buf
    local win_ids = vim.fn.win_findbuf(buf_id)
    for _, v in ipairs(win_ids) do
      vim.wo[v].signcolumn = "yes"
    end
  end,
})
vim.api.nvim_create_autocmd('LspDetach', {
  callback = function(ev)
    local buf_id = ev.buf
    local win_ids = vim.fn.win_findbuf(buf_id)
    for _, v in ipairs(win_ids) do
      vim.wo[v].signcolumn = "auto"
    end
  end,
})

vim.lsp.enable(server_list)
