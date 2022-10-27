local cmp = require("cmp")

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local cmp_keymaps = {
  ["<CR>"] = cmp.mapping.confirm({ select = true }),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item();
    elseif check_backspace() then
      fallback()
    else
      fallback();
    end
  end, {"i", "s"}),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
          cmp.select_prev_item()
      else
          fallback()
      end
  end, {"i", "s"}),
  ["<C-k>"] = cmp.mapping.select_prev_item(),
  ["<C-j>"] = cmp.mapping.select_next_item(),
  ["<C-e>"] = cmp.mapping {
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  },
  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  -- 如果窗口内容太多，可以滚动
  ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
  ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
}

local function cmp_format(entry, vim_item)
  local lspkind_icons = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
  }
  -- load lspkind icons
  vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)
  vim_item.menu = ({
      nvim_lsp = "[LSP]",
      buffer = "[BUF]",
      path = "[PATH]",
  })[entry.source.name]

  return vim_item
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  formatting = { format = cmp_format },
  mapping = cmp_keymaps,
})

-- / Search mode using souce `buffer`
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

-- : cmd mode using source `path` and `cmdline`.
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})