return {
  "neovim/nvim-lspconfig",
  opts = {
    -- make sure mason installs the server
    servers = {
      ---@type lspconfig.options.tsserver
      tsserver = {
        settings = {
          typescript = {
            preferences = {
              importModuleSpecifier = "project-relative",
            },
          },
          javascript = {
            preferences = {
              importModuleSpecifier = "project-relative",
            },
          },
          completions = {
            completeFunctionCalls = true,
          },
        },
      },
    },
  },
}
