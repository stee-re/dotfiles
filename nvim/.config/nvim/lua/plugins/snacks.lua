return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          -- Show hidden/ignored files in the explorer (<leader>e)
          explorer = {
            hidden = true,
            ignored = true,
          },
          -- Show hidden/ignored files in the file finder (<leader><leader>)
          files = {
            hidden = true,
          },
          -- Also apply to grep (<leader>/)
          grep = {
            hidden = true,
          },
          -- Filter LSP symbols to top-level constructs only
          lsp_symbols = {
            filter = {
              kind = {
                "Class",
                "Constructor",
                "Enum",
                "Field",
                "Function",
                "Interface",
                "Method",
                "Module",
                "Namespace",
                "Property",
                "Struct",
              },
            },
          },
        },
      },
    },
  },
}
