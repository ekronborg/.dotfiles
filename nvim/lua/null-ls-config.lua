local null_ls = require("null-ls")

--  `--prose-wrap` is needed for prettier to wrap lines,
--  see https://prettier.io/docs/en/options.html#prose-wrap for more information
local sources = {
    null_ls.builtins.formatting.prettier.with({
        extra_filetypes = { "vimwiki" },
        extra_args = { "--prose-wrap", "always", "--print-width", "120" },
    }),
}

null_ls.setup({ sources = sources })
