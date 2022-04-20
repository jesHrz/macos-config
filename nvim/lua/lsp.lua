local status, lsp_installer = pcall(require, "nvim-lsp-installer")

if not status then
  vim.notify("plugin nvim-lsp-installer not found")
end

local servers = {
  "clangd",
  "rust_analyzer",
  "sumneko_lua",
}

local mapbuf = require("keymaps").mapbuf

local function lsp_keymaps(bufnr)
  -- Without Lspsaga
  -- mapbuf(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  -- -- code action
  -- mapbuf(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  -- -- go xx
  mapbuf(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  -- mapbuf(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
  -- mapbuf(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  -- mapbuf(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  -- mapbuf(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  -- -- diagnostic
  -- mapbuf(bufnr, "n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>")
  -- mapbuf(bufnr, "n", "d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  -- mapbuf(bufnr, "n", "d]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  -- -- format
  -- mapbuf(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")

  -- Lspsaga enabled
  -- rename
  mapbuf(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
  -- code action
  mapbuf(bufnr, "n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
  -- hover
  mapbuf(bufnr, "n", "gh", "<cmd>Lspsaga hover_doc<CR>")
  -- reference
  mapbuf(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  -- diagnostic
  mapbuf(bufnr, "n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>")
  mapbuf(bufnr, "n", "d[", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
  mapbuf(bufnr, "n", "d]", "<cmd>Lspsaga diagnostic_jump_next()<CR>")

end

for name,_ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and (not server:is_installed()) then
    print("Installing " .. name)
    server:install()
  end
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
})

lsp_installer.on_server_ready(function(server)
  server:setup{
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      lsp_keymaps(bufnr)
    end
  }
end)
