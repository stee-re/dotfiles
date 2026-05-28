return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        markdown = {
          "prettier",
          "markdownlint-cli2",
          "markdown-toc",
        },
        ["markdown.mdx"] = {
          "prettier",
          "markdownlint-cli2",
          "markdown-toc",
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = {
            "--disable",
            "MD013",
            "--",
          },
        },
      },
    },
  },
}
