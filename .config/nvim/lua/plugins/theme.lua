return {
    {
        "bjarneo/aether.nvim",
        name = "aether",
        priority = 1000,
        opts = {
            disable_italics = false,
            colors = {
                -- Monotone shades (base00-base07)
                base00 = "#1A1B26", -- Default background
                base01 = "#898a9d", -- Lighter background (status bars)
                base02 = "#1A1B26", -- Selection background
                base03 = "#898a9d", -- Comments, invisibles
                base04 = "#ABAFCF", -- Dark foreground
                base05 = "#e5e6f1", -- Default foreground
                base06 = "#e5e6f1", -- Light foreground
                base07 = "#ABAFCF", -- Light background

                -- Accent colors (base08-base0F)
                base08 = "#977DC8", -- Variables, errors, red
                base09 = "#cabce5", -- Integers, constants, orange
                base0A = "#8678B1", -- Classes, types, yellow
                base0B = "#8E92AE", -- Strings, green
                base0C = "#adb0c7", -- Support, regex, cyan
                base0D = "#9d9db9", -- Functions, keywords, blue
                base0E = "#9C90C6", -- Keywords, storage, magenta
                base0F = "#b9b1d4", -- Deprecated, brown/yellow
            },
        },
        config = function(_, opts)
            require("aether").setup(opts)
            vim.cmd.colorscheme("aether")

            -- Enable hot reload
            require("aether.hotreload").setup()
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "aether",
        },
    },
}
