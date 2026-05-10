local root_markers1 = {
  ".emmyrc.json",
  ".luarc.json",
  ".luarc.jsonc",
}
local root_markers2 = {
  ".luacheckrc",
  ".stylua.toml",
  "stylua.toml",
  "selene.toml",
  "selene.yml",
}

local nvim_config_extend = {
  runtime = {
    version = "LuaJIT",
    path = {
      "lua/?.lua",
      "lua/?/init.lua",
    },
  },
  workspace = {
    checkThirdParty = false,
    library = vim.list_extend({
        vim.env.VIMRUNTIME,
        vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
        -- "${3rd}/luv/library",
        -- "${3rd}/busted/library",
      },
      vim.tbl_filter(function(path)
        local data = vim.fn.stdpath("data") .. "/site/pack/core/opt"
        return vim.startswith(path, data)
      end, vim.api.nvim_list_runtime_paths())
    )
  }
}

local nvim_data_extend = {
  runtime = {
    version = "LuaJIT",
    path = {
      "lua/?.lua",
      "lua/?/init.lua",
    },
  },
  workspace = {
    checkThirdParty = false,
    library = {
      vim.env.VIMRUNTIME,
      vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
      -- "${3rd}/luv/library",
      -- "${3rd}/busted/library",
    }
  }
}

---@type vim.lsp.Config
return {
  on_init = function(client)
    if not client.workspace_folders then
      return
    end
    if vim.startswith(client.workspace_folders[1].name, vim.fn.stdpath("data")) then
      ---@diagnostic disable-next-line: param-type-mismatch
      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, nvim_data_extend)
    end
    if client.workspace_folders[1].name == vim.fn.stdpath("config") then
      ---@diagnostic disable-next-line: param-type-mismatch
      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, nvim_config_extend)
    end
  end,

  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { root_markers1, root_markers2, { ".git" } },
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = { enable = true, semicolon = "Disable" },
    },
  },
}
