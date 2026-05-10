-- === OPTIONS ===
-- Encoding
vim.o.fileencoding = "utf-8"
vim.o.encoding = "utf-8"

-- Tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.smartindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

-- Undodir
vim.o.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.o.undofile = true

-- Visualization
vim.o.showmatch = true
vim.o.number = true
vim.o.relativenumber = true
-- vim.o.laststatus = 0
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.hidden = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "_" }
vim.o.winborder = "rounded"
vim.o.showtabline = 2

vim.o.timeoutlen = 500

-- Disable autocomments
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt_local.formatoptions:remove{ "c", "r", "o" }
  end
})

-- === KEYMAPS ===

-- Russian keymaps
vim.o.langmap =
"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,ЁЖЭХЪБЮ;~:\"{}<>,хъэ;[]'"
vim.keymap.set("ca", "й", "q")
vim.keymap.set("ca", "ц", "w")
vim.keymap.set("ca", "цй", "wq")

local opts = { silent = true }

vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<Esc>", opts)

-- Visualization
vim.keymap.set("n", "<leader><Space>", ":nohlsearch<Bar>:echo<CR>", opts)
vim.keymap.set("n", "<leader>n", ":set relativenumber!<CR>", opts)

-- Better window management
vim.keymap.set("n", "<A-h>", "<C-w>h", opts)
vim.keymap.set("n", "<A-j>", "<C-w>j", opts)
vim.keymap.set("n", "<A-k>", "<C-w>k", opts)
vim.keymap.set("n", "<A-l>", "<C-w>l", opts)
vim.keymap.set("n", "<A-->", "<C-w>-", opts)
vim.keymap.set("n", "<A-=>", "<C-w>+", opts)
vim.keymap.set("n", "<A-,>", "<C-w><", opts)
vim.keymap.set("n", "<A-.>", "<C-w>>", opts)
vim.keymap.set("n", "<A-t>", "<C-w>T", opts)
vim.keymap.set("n", "<A-o>", "<C-w>o", opts)

-- Terminal
vim.keymap.set("n", "<C-\\>", function()
  vim.cmd.new()
  vim.cmd.wincmd("J")
  vim.cmd.resize("10")
  vim.cmd.terminal()
end, opts)
vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", opts)
vim.keymap.set("t", "<A-h>", "<C-\\><C-n><C-w>h", opts)
vim.keymap.set("t", "<A-j>", "<C-\\><C-n><C-w>j", opts)
vim.keymap.set("t", "<A-k>", "<C-\\><C-n><C-w>k", opts)
vim.keymap.set("t", "<A-l>", "<C-\\><C-n><C-w>l", opts)

-- Buffers and Tabs
-- vim.keymap.set("n", "<C-l>", ":bn<CR>", opts)
-- vim.keymap.set("n", "<C-h>", ":bp<CR>", opts)
-- vim.keymap.set("n", "<leader>w", ":bd<CR>", opts)
-- vim.keymap.set("n", "<leader>W", ":%bd<CR>", opts)
vim.keymap.set("n", "<C-l>", "gt", opts)
vim.keymap.set("n", "<C-h>", "gT", opts)
vim.keymap.set("n", "<leader>w", ":close<CR>", opts)
vim.keymap.set("n", "<leader><C-]>", ":set lz<CR><C-w><C-]><C-w>T:set nolz<CR>", opts)

-- Text operations
vim.keymap.set("n", "<C-p>", ":set lz<CR>viwP:set nolz<CR>", opts)
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Motions
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- === USER COMMANDS ===
vim.api.nvim_create_user_command("PackSync", function()
  vim.pack.update()
  local plugins_to_purge = vim.iter(vim.pack.get())
      :filter(function(x) return not x.active end)
      :map(function(x) return x.spec.name end)
      :totable()
  vim.pack.del(plugins_to_purge)
  if #plugins_to_purge > 0 then
    vim.notify("vim.pack: Purged " .. #plugins_to_purge .. " plugins.", vim.log.levels.INFO)
  end
end, {})

--- === FILETYPES ===
vim.filetype.add{
  pattern = {
    ["(.*)%.disabled"] = function (path, bufnr, filename)
      return vim.filetype.match{bufnr = bufnr, filename = filename}
    end
  }
}
