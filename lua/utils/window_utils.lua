M = {}

--- Creates a new, floating window.
---
--- @param listed boolean Sets 'buflisted'
--- @param scratch boolean Creates a "throwaway" `scratch-buffer` for temporary work
--- (always 'nomodified'). Also sets 'nomodeline' on the buffer.
--- @param enter boolean Enter the window (make it the current window)
--- @treturn
---   - `buf_id` (number) id of the buffer inside the created window
---   - `win_id` (number) id of the created window
M.create_float_window = function(listed, scratch, enter, opts)
  opts = opts or {}
  local win_opts = {
    relative = opts.relative or "editor",
    style = opts.style or "minimal",
  }
  win_opts.width = opts.width or math.floor(vim.o.columns * 0.8)
  win_opts.height = opts.height or math.floor(vim.o.lines * 0.8)
  win_opts.row = opts.row or (vim.o.lines - win_opts.height) / 2 - 1
  win_opts.col = opts.col or (vim.o.columns - win_opts.width) / 2 - 1

  local buf_id = vim.api.nvim_create_buf(listed, scratch)
  local win_id = vim.api.nvim_open_win(buf_id, enter, win_opts)

  return { buf_id = buf_id, win_id = win_id }
end

return M
