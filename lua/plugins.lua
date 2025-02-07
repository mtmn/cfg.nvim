return {
    {
        "miikanissi/modus-themes.nvim",
        version = false,
        lazy = false,
        priority = 1000,
        config = function()
            require("modus-themes").setup(
                {
                    transparent = true,
		    variant = "tinted",
		    dim_inactive = true,
		    line_nr_column_background = true,
		    hide_inactive_statusline = false,
		}
            )

            vim.cmd([[colorscheme modus_vivendi]])
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = true
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = {"n", "x", "o"},
                function()
                    require("flash").jump()
                end
            },
            {
                "S",
                mode = {"n", "x", "o"},
                function()
                    require("flash").treesitter()
                end
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end
            },
            {
                "R",
                mode = {"o", "x"},
                function()
                    require("flash").treesitter_search()
                end
            },
            {
                "<c-s>",
                mode = {"c"},
                function()
                    require("flash").toggle()
                end
            }
        }
    },
    {
        "ibhagwan/fzf-lua",
        config = true
    },
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim"
        },
        config = true
    },
    {
        "ray-x/go.nvim",
        config = function()
            require("go").setup()
        end,
        event = {"CmdlineEnter"},
        ft = {"go", "gomod"},
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-vsnip"
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup(
                {
                    snippet = {
                        expand = function(args)
                            require("luasnip").lsp_expand(args.body)
                        end
                    },
                    window = {
                        completion = {
                            winhighlight = "Normal:CmpNormal"
                        },
                        documentation = {
                            winhighlight = "Normal:CmpNormal"
                        }
                    },
                    mapping = cmp.mapping.preset.insert(
                        {
                            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                            ["<C-f>"] = cmp.mapping.scroll_docs(4),
                            ["<C-Space>"] = cmp.mapping.complete(),
                            ["<C-e>"] = cmp.mapping.abort(),
                            ["<CR>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                        }
                    ),
                    sources = cmp.config.sources(
                        {
                            {name = "nvim_lsp"},
                            {name = "luasnip"}
                        },
                        {
                            {name = "buffer"}
                        }
                    )
                }
            )
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim"
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup(
                {
                    ensure_installed = {
                        "lemminx",
                        "marksman",
                        "yamlls",
                        "dockerls",
                        "bashls",
                        "gopls"
                    }
                }
            )
            require("mason-tool-installer").setup(
                {
                    ensure_installed = {}
                }
            )
		local lspconfig = require("lspconfig")
		lspconfig.gopls.setup({
		settings = {
		    gopls = {
		    analyses = {
			unusedparams = true,
		    },
		    staticcheck = true,
		    gofumpt = true,
		    },
		},
		})

            local open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or "rounded"
                return open_floating_preview(contents, syntax, opts, ...)
            end
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup(
                {
                    ensure_installed = {
                        "bash",
                        "go",
                        "java",
                        "json",
                        "lua",
                        "nix",
                        "markdown",
                        "python",
                        "xml",
                        "yaml"
                    },
                    sync_install = false,
                    highlight = {enable = true},
                    indent = {enable = true}
                }
            )
        end
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip"
        }
    },
    {
        "tpope/vim-commentary",
        "tpope/vim-repeat",
        "tpope/vim-surround"
    },
    {
        "troydm/zoomwintab.vim"
    },
    {
        "f-person/git-blame.nvim",
	event = "VeryLazy",
	opts = {
	    enabled = false,
	    message_template = " <summary> • <date> • <author> • <<sha>>",
	    date_format = "%m-%d-%Y %H:%M:%S",
	    virtual_text_column = 1,
	}
    },
}
