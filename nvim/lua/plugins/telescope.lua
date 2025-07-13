return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        tags = {
          fname_width = 80,
        },
        current_buffer_tags = {
          fname_width = 80,
        },
        quickfix = {
          fname_width = 80,
        },
        loclist = {
          fname_width = 80,
        },
        lsp_references = {
          fname_width = 80,
        },
        lsp_definitions = {
          fname_width = 80,
        },
      },
    },
    keys = {
      {
        "<leader><space>",
        function()
          require("telescope.builtin").find_files({ cwd = vim.loop.cwd() })
        end,
        desc = "Find File (cwd)",
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep({ cwd = vim.loop.cwd() })
        end,
        desc = "Find in Files (cwd)",
      },
    },
  },
}
