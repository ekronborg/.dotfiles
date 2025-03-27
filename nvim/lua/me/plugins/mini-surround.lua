return {
    "echasnovski/mini.surround",
    version = false,
    event = "LazyFile",
    opts = {
        -- Default 's<suffix>' mappings clashes with 's'.
        mappings = {
            add = "gsa",
            delete = "gsd",
            find = "gsf",
            find_left = "gsF",
            highlight = "gsh",
            replace = "gsr",
            update_n_lines = "gsn",
        },
    },
}
