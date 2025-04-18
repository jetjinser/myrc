local M = {}

---@return (LazyKeys|{has?:string})[]
function M.get()
  return {
    { "<leader>cd", vim.diagnostic.open_float,   desc = "Line Diagnostics" },
    { "gd",         vim.lsp.buf.definition,      desc = "Goto Definition" },
    { "gr",         vim.lsp.buf.references,      desc = "References" },
    { "gt",         vim.lsp.buf.type_definition, desc = "Goto Type Definition" },
    { "gD",         vim.lsp.buf.declaration,     desc = "Goto Declaration" },
    { "gI",         vim.lsp.buf.implementation,  desc = "Goto Implementation" },
    { "K",          vim.lsp.buf.hover,           desc = "Hover" },
    {
      "gK",
      vim.lsp.buf.signature_help,
      desc = "Signature Help",
      has = "signatureHelp"
    },
    {
      "<c-k>",
      vim.lsp.buf.signature_help,
      mode = "i",
      desc = "Signature Help",
      has = "signatureHelp"
    },
    { "]d", M.diagnostic_goto(true),           desc = "Next Diagnostic" },
    { "[d", M.diagnostic_goto(false),          desc = "Prev Diagnostic" },
    { "]e", M.diagnostic_goto(true, "ERROR"),  desc = "Next Error" },
    { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
    { "]w", M.diagnostic_goto(true, "WARN"),   desc = "Next Warning" },
    { "[w", M.diagnostic_goto(false, "WARN"),  desc = "Prev Warning" },
    {
      "<leader>ca",
      vim.lsp.buf.code_action,
      desc = "Code Action",
      mode = { "n", "v" },
      has = "codeAction"
    },
    {
      "<leader>cf",
      function() vim.lsp.buf.format { async = true } end,
      desc = "Format Document",
      has = "documentFormatting"
    },
    {
      "<leader>cf",
      function() vim.lsp.buf.format { async = true } end,
      desc = "Format Range",
      mode = "v",
      has = "documentRangeFormatting"
    },
    {
      "<leader>cr",
      vim.lsp.buf.rename,
      expr = true,
      desc = "Rename",
      has = "rename"
    },
    {
      "<leader>it",
      function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      desc = "toggle inlay hints",
    },
    {
      "<leader>ia",
      function()
        local current_buffer = vim.api.nvim_get_current_buf()

        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1] - 1;
        -- local col = cursor[2]

        local range = {
          start = { line = row, character = 0 },
          ['end'] = { line = row, character = 1000 },
        }

        -- TODO: use <cword> range

        local hints = vim.lsp.inlay_hint.get({ bufnr = current_buffer, range = range, })

        for _, hint in ipairs(hints) do
          vim.print(hint.inlay_hint.textEdits)
          vim.lsp.util.apply_text_edits(hint.inlay_hint.textEdits, current_buffer, "utf-8")
        end
      end,
      desc = "apply current line inlay hints textEdits",
    },
  }
end

function M.on_attach(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

  for _, value in ipairs(M.get()) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      local opts = Keys.opts(keys)
      ---@diagnostic disable-next-line: no-unknown
      opts.has = nil
      opts.silent = true
      opts.buffer = buffer
      vim.keymap.set(keys.mode, keys.lhs, keys.rhs, opts)
    end
  end

  -- vim.api.nvim_create_user_command("ApplyIHTextEdits", function(command)
  --   if client.supports_method("textDocument/inlayHint") then
  --     local hint = vim.lsp.inlay_hint.get({ bufnr = 0 })[n]
  --     vim.print(hint);
  --
  --     local client = vim.lsp.get_client_by_id(hint.client_id)
  --     -- resolved_hint = client.request_sync('inlayHint/resolve', hint.inlay_hint, 100, 0).result
  --     vim.lsp.util.apply_text_edits(hint.textEdits, 0, client.encoding)
  --
  --     location = resolved_hint.label[1].location
  --   else
  --     print("unsupport inlay hints")
  --   end
  -- end, {})

end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return M
