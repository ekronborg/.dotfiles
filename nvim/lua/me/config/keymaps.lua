-- Map Q to something useful
vim.keymap.set("n", "Q", "<cmd>q<cr>")

-- Keep selection when shifting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Keeping the cursor centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")

-- Keep selection when moving lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Move in long lines
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Credits to https://github.com/tpope/vim-unimpaired
vim.keymap.set("n", "[q", "<cmd>cprev<cr>zz")
vim.keymap.set("n", "]q", "<cmd>cnext<cr>zz")

vim.keymap.set("n", "[b", "<cmd>bprev<cr>zz")
vim.keymap.set("n", "]b", "<cmd>bnext<cr>zz")

vim.keymap.set("n", "[l", "<cmd>lprev<cr>zz")
vim.keymap.set("n", "]l", "<cmd>lnext<cr>zz")

-- TODO: explain these
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Make esc work in the integrated terminal emulator
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Open tag in new tab
-- vim.keymap.set("n", "<leader>t", ":tab tag <c-r><c-w><cr>", { silent = true })

-- Helper functions for notes
vim.keymap.set("n", "<leader>nn", ":e ~/notes/")
