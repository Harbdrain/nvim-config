local hooks = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
    vim.system({ "make" }, { cwd = ev.data.path })
  end
end
local pack_changed_group = vim.api.nvim_create_augroup("PostPackHook", {
  clear = false
})
vim.api.nvim_create_autocmd("PackChanged", { group = pack_changed_group, callback = hooks })

local gh = require("utils.pack-helper").gh
vim.pack.add {
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("nvim-telescope/telescope-fzf-native.nvim"),
  {
    src = gh("nvim-telescope/telescope.nvim"),
    version = vim.version.range("<0.5")
  },
  gh("nvim-telescope/telescope-ui-select.nvim")
}

local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown()
    }
  }
}

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

local builtin = require("telescope.builtin")
local opts = { silent = true }

vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
