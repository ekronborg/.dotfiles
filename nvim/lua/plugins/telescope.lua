-- Telescope setup
local telescope = require("telescope")
telescope.setup({
    pickers = {
        find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--follow", "--exclude", ".git" },
        },
    },
})
telescope.load_extension("fzf")

-- Helper functions
local M = {}
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

function M.search_notes()
    builtin.find_files({
        cwd = "~/notes",
        prompt_title = "Search notes",
    })
end

function M.grep_notes()
    builtin.live_grep({
        cwd = "~/notes",
        prompt_title = "Grep notes",
    })
end

function M.spell_check()
    builtin.spell_suggest(themes.get_cursor({
        prompt_title = "",
        layout_config = {
            height = 0.25,
            width = 0.25,
        },
    }))
end

function M.project_files()
    local ok = pcall(builtin.git_files)
    if not ok then
        builtin.find_files()
    end
end

return M
