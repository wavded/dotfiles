local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local kind_symbols = {
	Text = "",
	Method = "Ƒ",
	Function = "ƒ",
	Constructor = "",
	Variable = "",
	Class = "",
	Interface = "ﰮ",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "了",
	Keyword = "",
	Snippet = "﬌",
	Color = "",
	File = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
}

lspkind.init({ symbol_map = kind_symbols })

cmp.setup({
	completion = { completeopt = "menu,menuone,noinsert" },
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }),
	},

	mapping = {
		["<cr>"] = cmp.mapping.confirm(),
		["<tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.jump(1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<s-tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},

	sources = {
		{ name = "buffer" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "luasnip" },
	},
})
