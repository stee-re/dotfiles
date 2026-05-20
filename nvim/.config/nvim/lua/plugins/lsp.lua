return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        vtsls = function(_, opts)
          opts.on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end,
      },
    },
  },
}
