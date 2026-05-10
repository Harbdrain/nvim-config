local gh = require("utils.pack-helper").gh
vim.pack.add{ gh("nvim-mini/mini.notify") }

local ok, mini_notify = pcall(require, "mini.notify")
if not ok then
  return
end

mini_notify.setup{
  window = {
    config = {
      border = "single"
    },
  },
  content = {
    sort = function(notif_arr)
      local filtered_strings = {
        "jdtls: Validate documents",
        "jdtls: Publish Diagnostics",
        "jdtls: Building",
        "jdtls: Update classpath Job",
        "pyright: (100%)"
      }

      local filter = function(notif)
        for _, filtered_string in ipairs(filtered_strings) do
          if notif.msg:find(filtered_string, 1, true) then
            return false
          end
        end

        return true
      end

      notif_arr = vim.tbl_filter(filter, notif_arr)
      return mini_notify.default_sort(notif_arr)
    end
  }
}

vim.notify = mini_notify.make_notify()

local float_win = {}

local close_float_window = function()
  vim.api.nvim_win_close(float_win.win_id, false)
end

local show_history = function()
  float_win = require("utils.window_utils").create_float_window(false, true, true)
  require("mini.notify").show_history()
  vim.api.nvim_buf_delete(float_win.buf_id, {})

  local notify_history_buf_id
  for _, id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[id].filetype == "mininotify-history" then notify_history_buf_id = id end
  end
  float_win.buf_id = notify_history_buf_id

  if notify_history_buf_id then
    vim.keymap.set("n", "q", close_float_window, { buffer = float_win.buf_id, silent = true })
  end
end

vim.keymap.set("n", "<leader>nh", show_history, { silent = true })
