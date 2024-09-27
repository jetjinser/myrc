local create_cmd = vim.api.nvim_create_user_command

create_cmd("Grep", function(opts)
  local args = opts.fargs;
  local cmd = "grep! " .. table.concat(args, " ");
  vim.cmd("silent " .. cmd)
  vim.cmd("copen")
end, { nargs = "+" })
