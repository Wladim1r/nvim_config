local colors = {
	keyword = "#cc91f0",
	control = "#d5f5f8",
	string = "#A8E4A0",
	function_name = "#48bfe3",
	func = "#ff99ff",
	type = "#ff99ff",
	null_bool = "#d00000",
	import = "#ff70a6",
	punctuation = "#d2fbff",
	escape = "#f9c74f",
	placeholder = "#ff99c8",
	comment = "#b8f2e6",
	storage = "#9cf4fe",
	module = "#8eecf5",
	variable = "#cae9ff",
	constVar = "#ffe5ec",
	typeName = "#00dcff",
	varInStruct = "#70d6ff",
	typeVarInStruct = "#8eecf5",
	Namefunction = "#B975FF",
	conditional = "#9bf6ff",
	callFunction = "#70DEFF",
	number = "#c4fff9",
	character = "#ff99c8",
	builtinFunc = "#00dcff",
	property = "#48cae4",
	t = "#00dcff",
	callFunc = "#fdf0d5",
	fu = "#E00000",
}

vim.api.nvim_set_hl(0, "@keyword.import.go", { fg = colors.import, italic = true, bold = true }) -- package, import
vim.api.nvim_set_hl(0, "@constant.go", { fg = colors.constVar, italic = true }) -- const
vim.api.nvim_set_hl(0, "@keyword.type.go", { fg = colors.type, italic = true, bold = true }) -- type
vim.api.nvim_set_hl(0, "@type.definition.go", { fg = colors.typeName, italic = true, bold = true }) -- type`s name
vim.api.nvim_set_hl(0, "@variable.member.go", { fg = colors.varInStruct }) -- name var in Struct
vim.api.nvim_set_hl(0, "@type.builtin.go", { fg = colors.typeVarInStruct, italic = true }) -- type of name in Struct
vim.api.nvim_set_hl(0, "@function.builtin", { fg = colors.builtinFunc, italic = true })
vim.api.nvim_set_hl(0, "@function.method.go", { fg = colors.Namefunction, italic = true }) -- function name
vim.api.nvim_set_hl(0, "@function.go", { fg = colors.fu })
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = colors.punctuation })
vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = colors.punctuation })
vim.api.nvim_set_hl(0, "@keyword.function.go", { fg = colors.func, italic = true, bold = true }) -- func
vim.api.nvim_set_hl(0, "@keyword.go", { fg = colors.conditional, italic = true, bold = true })
vim.api.nvim_set_hl(0, "@keyword.conditional.go", { fg = colors.conditional, italic = true, bold = true })
vim.api.nvim_set_hl(0, "@keyword.return.go", { fg = colors.conditional, italic = true, bold = true })
vim.api.nvim_set_hl(0, "@keyword.repeat.go", { fg = colors.conditional, italic = true, bold = true })
vim.api.nvim_set_hl(0, "@keyword.coroutine.go", { fg = colors.conditional, italic = true, bold = true })
vim.api.nvim_set_hl(0, "@function.method.call.go", { fg = colors.callFunction })
vim.api.nvim_set_hl(0, "@function.call.go", { fg = colors.callFunc })
vim.api.nvim_set_hl(0, "@number.float.go", { fg = colors.number })
vim.api.nvim_set_hl(0, "@number.go", { fg = colors.number })
vim.api.nvim_set_hl(0, "@character.printf", { fg = colors.character, italic = true })
vim.api.nvim_set_hl(0, "@variable.parameter.go", { fg = colors.variable })
vim.api.nvim_set_hl(0, "@string", { fg = colors.string })
vim.api.nvim_set_hl(0, "@property.go", { fg = colors.property })
vim.api.nvim_set_hl(0, "@module.go", { fg = colors.module })
vim.api.nvim_set_hl(0, "@function", { fg = colors.function_name }) -- entity.name.function
vim.api.nvim_set_hl(0, "@type.go", { fg = colors.t }) -- entity.name.type.go
vim.api.nvim_set_hl(0, "@constant.builtin", { fg = colors.null_bool, italic = true, bold = true })
vim.api.nvim_set_hl(0, "@boolean.go", { fg = colors.null_bool, italic = true, bold = true })
vim.api.nvim_set_hl(0, "@include.go", { fg = colors.import, italic = true }) -- entity.name.import.go
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = colors.punctuation }) -- . , :
vim.api.nvim_set_hl(0, "@string.escape", { fg = colors.escape }) -- constant.character.escape.go
vim.api.nvim_set_hl(0, "@string.special", { fg = colors.placeholder }) -- constant.other.placeholder.go
vim.api.nvim_set_hl(0, "@comment", { fg = colors.comment, italic = true }) -- comment.line.double-slash.go
vim.api.nvim_set_hl(0, "@type.qualifier", { fg = colors.storage }) -- storage.type.*
