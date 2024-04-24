-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  },
  -- {
  --   "gbprod/nord.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   -- config = function()
  --   --   require("nord").setup({})
  --   --   vim.cmd.colorscheme("nord")
  --   -- end,
  -- },


  -- {
  --   -- Theme
  --   'nordtheme/vim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'nord'
  --   end,
  -- },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        -- theme = 'nord',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "elentok/format-on-save.nvim",
  },
  {
    'sbdchd/neoformat',
  },
  {
    'rebelot/kanagawa.nvim',
    config = function()
      vim.cmd.colorscheme 'kanagawa'
    end,

  },
  -- {
  --   "tadmccorkle/markdown.nvim",
  --   ft = "markdown", -- or 'event = "VeryLazy"'
  --   opts = {
  --     on_attach = function(bufnr)
  --       local function toggle(key)
  --         return "<Esc>gv<Cmd>lua require'markdown.inline'"
  --             .. ".toggle_emphasis_visual'" .. key .. "'<CR>"
  --       end
  --
  --       vim.keymap.set("x", "<C-b> <C-b>", toggle("b"), { buffer = bufnr })
  --       vim.keymap.set("x", "<C-i>", toggle("i"), { buffer = bufnr })
  --     end,
  --     -- configuration here or empty for defaults
  --   },
  -- },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --     "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
  --   }
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    'ggandor/leap.nvim',
    dependencies = {
      'tpope/vim-repeat'
    }

  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
  },



  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})



require('leap').create_default_mappings()

require("headlines").setup {
  markdown = {
    query = vim.treesitter.query.parse(
      "markdown",
      [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
                (block_quote (paragraph (block_continuation) @quote))
                (block_quote (block_continuation) @quote)
            ]]
    ),
    headline_highlights = { "Headline" },
    bullet_highlights = {
      "@text.title.1.marker.markdown",
      "@text.title.2.marker.markdown",
      "@text.title.3.marker.markdown",
      "@text.title.4.marker.markdown",
      "@text.title.5.marker.markdown",
      "@text.title.6.marker.markdown",
    },
    bullets = { "◉", "○", "✸", "✿" },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    dash_string = "-",
    quote_highlight = "Quote",
    quote_string = "┃",
    fat_headlines = true,
    fat_headline_upper_string = "▃",
    fat_headline_lower_string = "▀",
  },
  rmd = {
    query = vim.treesitter.query.parse(
      "markdown",
      [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
                (block_quote (paragraph (block_continuation) @quote))
                (block_quote (block_continuation) @quote)
            ]]
    ),
    treesitter_language = "markdown",
    headline_highlights = { "Headline" },
    bullet_highlights = {
      "@text.title.1.marker.markdown",
      "@text.title.2.marker.markdown",
      "@text.title.3.marker.markdown",
      "@text.title.4.marker.markdown",
      "@text.title.5.marker.markdown",
      "@text.title.6.marker.markdown",
    },
    bullets = { "◉", "○", "✸", "✿" },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    dash_string = "-",
    quote_highlight = "Quote",
    quote_string = "┃",
    fat_headlines = true,
    fat_headline_upper_string = "▃",
    fat_headline_lower_string = "▀",
  },
  -- norg = {
  --     query = vim.treesitter.parse_query(
  --         "norg",
  --         [[
  --             [
  --                 (heading1_prefix)
  --                 (heading2_prefix)
  --                 (heading3_prefix)
  --                 (heading4_prefix)
  --                 (heading5_prefix)
  --                 (heading6_prefix)
  --             ] @headline
  --
  --             (weak_paragraph_delimiter) @dash
  --             (strong_paragraph_delimiter) @doubledash
  --
  --             ([(ranged_tag
  --                 name: (tag_name) @_name
  --                 (#eq? @_name "code")
  --             )
  --             (ranged_verbatim_tag
  --                 name: (tag_name) @_name
  --                 (#eq? @_name "code")
  --             )] @codeblock (#offset! @codeblock 0 0 1 0))
  --
  --             (quote1_prefix) @quote
  --         ]]
  --     ),
  --     headline_highlights = { "Headline" },
  --     bullet_highlights = {
  --         "@neorg.headings.1.prefix",
  --         "@neorg.headings.2.prefix",
  --         "@neorg.headings.3.prefix",
  --         "@neorg.headings.4.prefix",
  --         "@neorg.headings.5.prefix",
  --         "@neorg.headings.6.prefix",
  --     },
  --     bullets = { "◉", "○", "✸", "✿" },
  --     codeblock_highlight = "CodeBlock",
  --     dash_highlight = "Dash",
  --     dash_string = "-",
  --     doubledash_highlight = "DoubleDash",
  --     doubledash_string = "=",
  --     quote_highlight = "Quote",
  --     quote_string = "┃",
  --     fat_headlines = true,
  --     fat_headline_upper_string = "▃",
  --     fat_headline_lower_string = "▀",
  -- },
  -- org = {
  --     query = vim.treesitter.parse_query(
  --         "org",
  --         [[
  --             (headline (stars) @headline)
  --
  --             (
  --                 (expr) @dash
  --                 (#match? @dash "^-----+$")
  --             )
  --
  --             (block
  --                 name: (expr) @_name
  --                 (#match? @_name "(SRC|src)")
  --             ) @codeblock
  --
  --             (paragraph . (expr) @quote
  --                 (#eq? @quote ">")
  --             )
  --         ]]
  --     ),
  --     headline_highlights = { "Headline" },
  --     bullet_highlights = {
  --         "@org.headline.level1",
  --         "@org.headline.level2",
  --         "@org.headline.level3",
  --         "@org.headline.level4",
  --         "@org.headline.level5",
  --         "@org.headline.level6",
  --         "@org.headline.level7",
  --         "@org.headline.level8",
  --     },
  --     bullets = { "◉", "○", "✸", "✿" },
  --     codeblock_highlight = "CodeBlock",
  --     dash_highlight = "Dash",
  --     dash_string = "-",
  --     quote_highlight = "Quote",
  --     quote_string = "┃",
  --     fat_headlines = true,
  --     fat_headline_upper_string = "▃",
  --     fat_headline_lower_string = "▀",
  -- },
}

-- -- Nord Theme
-- vim.g.nord_contrast = true
-- vim.g.nord_borders = false
-- vim.g.nord_disable_background = false
-- vim.g.nord_italic = false
-- vim.g.nord_uniform_diff_background = true
-- vim.g.nord_bold = false
--
-- -- Load the colorscheme
-- require('nord').set()
--

-- vim.cmd.colorscheme("nord")


