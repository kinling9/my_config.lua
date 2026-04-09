return function()
  -- require("conform").formatter.bibtextidy = {
  -- 	prepend_args = { "--sort=type,-year,name", "--sort-fields", "--blank-lines" },
  -- }
  require("conform").setup({
    formatters = {
      bibtextidy = {
        command = "bibtex-tidy",
        stdin = true,
        args = { "--sort=type,-year,name", "--sort-fields", "--blank-lines", "--quiet" },
      },
      ruff_organize_imports = {
        command = "ruff",
        args = {
          "check",
          "--force-exclude",
          "--select=I", -- Select only the "Isort" rule
          "--fix",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "ruff_organize_imports", "black" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      markdown = { "deno_fmt" },
      tex = { "latexindent" },
      bib = { "bibtextidy" },
      rust = { "rustfmt" },
      toml = { "taplo" },
      json = { "jq" },
      ["*"] = { "trim_whitespace", "trim_newlines" },
    },
  })
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require("conform").format({ bufnr = args.buf })
    end,
  })
end
