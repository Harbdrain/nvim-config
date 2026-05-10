local hooks = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == "LuaSnip" and (kind == "install" or kind == "update") then
    vim.system({ "make", "install_jsregexp" }, { cwd = ev.data.path })
  end
end
local pack_changed_group = vim.api.nvim_create_augroup("PostPackHook", {
  clear = false
})
vim.api.nvim_create_autocmd("PackChanged", { group = pack_changed_group, callback = hooks })

local gh = require("utils.pack-helper").gh
vim.pack.add{
  gh("rafamadriz/friendly-snippets"),
  {
    src = gh("L3MON4D3/LuaSnip"),
    versoin = vim.version.range("2.*")
  },
  {
    src = gh("saghen/blink.cmp"),
    version = vim.version.range("1.*")
  }
}

local ok, luasnip_loaders = pcall(require, "luasnip.loaders.from_vscode")
if not ok then
  return
end

luasnip_loaders.lazy_load{
  exclude = {
    "java"
  }
}

---@diagnostic disable-next-line: redefined-local
local ok, blink = pcall(require, "blink.cmp")
if not ok then
  return
end

blink.setup{
  keymap = {
    ["<Tab>"] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_next()
        end
      end,
      "snippet_forward",
      "fallback"
    },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<CR>"] = { "accept", "fallback" },

    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },

    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
  snippets = {
    preset = "luasnip"
  },
  completion = {
    list = {
      selection = {
        preselect = false
      }
    },
    trigger = {
      show_in_snippet = false
    },
    menu = {
      draw = {
        columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
      }
    }
  },
  fuzzy = {
    implementation = "rust",
  },
  cmdline = {
    enabled = true,
    completion = {
      list = {
        selection = {
          preselect = false
        }
      }
    }
  }
}
