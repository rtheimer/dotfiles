return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	-- ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		"BufReadPre "
			.. vim.fn.expand("~")
			.. "/Dokumente/brain/**.md",
		--"BufReadPre "
		--	.. vim.fn.expand("~/Dokumente/brain")
		--	.. "/**.md",
		"BufNewFile ~/Dokumente/brain/**.md",
	},
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "brain",
				path = "~/Dokumente/brain/",
			},
		},
		templates = {
			folder = "templates",
			date_format = "%a-%d-%m-%Y",
			time_format = "%H:%M",
		},
		picker = {
			name = "telescope.nvim",
		},
		disable_frontmatter = false,
		note_frontmatter_func = function(note)
			-- Add the title of the note as an alias.
			if note.title then
				note:add_alias(note.title)
			end

			-- Get the current date in the desired format (e.g., YYYY-MM-DD)
			local current_date = os.date("%d-%m-%Y")

			-- Initial out structure with basic fields and an empty 'author' and 'creation_date'
			local out = {
				id = note.id,
				aliases = note.aliases,
				tags = note.tags,
				context = "",
				source = "",
				author = "", -- Set 'author' field to an empty string
				creation_date = current_date, -- Set 'creation_date' to the current date
			}

			-- Keep manually added metadata in the frontmatter.
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end

			-- Return the extended out table with empty 'author' and 'creation_date'.
			return out
		end,

		notes_subdir = "new_notes",
		new_notes_location = "notes_subdir",
		-- Optional, customize how note IDs are generated given an optional title.
		---@param title string|?
		---@return string
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will be given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.time()) .. "-" .. suffix
		end,
	},
}
