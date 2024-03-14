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
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Credits to https://github.com/tpope/vim-unimpaired
vim.keymap.set("n", "[q", "<cmd>cprev<cr>zz")
vim.keymap.set("n", "]q", "<cmd>cnext<cr>zz")

vim.keymap.set("n", "[b", "<cmd>bprev<cr>zz")
vim.keymap.set("n", "]b", "<cmd>bnext<cr>zz")

vim.keymap.set("n", "[l", "<cmd>lprev<cr>zz")
vim.keymap.set("n", "]l", "<cmd>lnext<cr>zz")

-- Telescope functions. TIP: C-q will populate the quickfix list with the current contents
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<C-f>", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
-- vim.keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics<cr>")
-- vim.keymap.set("n", "<C-p>", require("plugins.telescope").project_files)
-- vim.keymap.set("n", "z=", require("plugins.telescope").spell_check)

-- TODO: explain these
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Requires undodir to be set. Defaults to $XDG_STATE_HOME/nvim/undo/ and is automatically created
-- Note that undofile must be true for persistence
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Open tag in new tab
vim.keymap.set("n", "<leader>t", ":tab tag <c-r><c-w><cr>", { silent = true })

-- Helper functions for notes
vim.keymap.set("n", "<leader>p", require("plugins.telescope").search_notes)
vim.keymap.set("n", "<leader>f", require("plugins.telescope").grep_notes)
vim.keymap.set("n", "<leader>nn", ":e ~/notes/")
