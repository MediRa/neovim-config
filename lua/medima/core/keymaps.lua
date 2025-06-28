vim.g.mapleader = " " -- Leader key
vim.g.have_nerd_font = true

local keymap = vim.keymap -- for conciseness

---------------
---- Remap ----
---------------
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move line down
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move line up
keymap.set("n", "n", "nzzzv") -- Make search result position on the middle
keymap.set("n", "N", "Nzzzv")
keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })

----------------------
---- Cursor keymap ----
----------------------
---
--- NOTE zz make the cursor centered or set :set scrollof = 999
-- keymap.set("n", "k", "kzz", { desc = "Make cursor vertically centered" })
-- keymap.set("n", "j", "jzz", { desc = "Make cursor vertically centered" })
--
-- keymap.set("v", "k", "kzz", { desc = "Make cursor vertically centered" })
-- keymap.set("v", "j", "jzz", { desc = "Make cursor vertically centered" })
---
------------------
---- Terminal ----
------------------
keymap.set("n", "<leader>ot", "<C-w>v :terminal<CR>", { desc = "Open terminal Mode" }) -- Open new window terminal within new tab
keymap.set("t", "<leader>et", "<C-\\><C-n><CR>", { desc = "Exit insert terminal" })

keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit insert terminal" }) -- Escape terminal insert mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>:q!<CR>", { desc = "Exit insert terminal" }) -- Escape terminal insert mode

keymap.set("t", "<leader>ct", "<C-\\><C-n>:q!<CR>", { desc = "Close terminal Mode" }) -- Close window terminal

-----------------
---- Command ---- -- doesnot work
-----------------
-- keymap.set("n", "<leader>wq", ":w<CR>", { desc = "Quit work" })
-- keymap.set("n", "<leader>ws", ":w<CR>", { desc = "Save work" })
-- keymap.set("n", "<leader>wsa", ":wall<CR>", { desc = "Save all work" })
-- keymap.set("n", "<leader>wsq", ":wq<CR>", { desc = "Save and quit" })
-- keymap.set("n", "<leader>wsqa", ":wqall<CR>", { desc = "Save all and quit" })

--------------------
---- Highlights ----
--------------------
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-------------------------------------
---- Increment/decrement numbers ----
-------------------------------------
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

---------------------------
---- Window management ----
---------------------------
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

---------------------------------
---- Move between window ----
---- Terminal Mode
keymap.set("t", "Mh", "<C-\\><C-n><C-w>h")
keymap.set("t", "Ml", "<C-\\><C-n><C-w>l")
keymap.set("t", "Mj", "<C-\\><C-n><C-w>j")
keymap.set("t", "Mk", "<C-\\><C-n><C-w>k")
--- Normal Mode
keymap.set("n", "Mh", "<C-w>h")
keymap.set("n", "Ml", "<C-w>l")
keymap.set("n", "Mj", "<C-w>j")
keymap.set("n", "Mk", "<C-w>k")
keymap.set("n", "<Esc>Mh", "<C-w>h")
keymap.set("n", "<Esc>Ml", "<C-w>l")
keymap.set("n", "<Esc>Mj", "<C-w>j")
keymap.set("n", "<Esc>Mk", "<C-w>k")
--- Insert Mode
keymap.set("i", "Mh", "<Esc><C-w>h")
keymap.set("i", "Ml", "<Esc><C-w>l")
keymap.set("i", "Mj", "<Esc><C-w>j")
keymap.set("i", "Mk", "<Esc><C-w>k")
--- Visual Mode
keymap.set("v", "Mh", "<Esc><C-w>h")
keymap.set("v", "Ml", "<Esc><C-w>l")
keymap.set("v", "Mj", "<Esc><C-w>j")
keymap.set("v", "Mk", "<Esc><C-w>k")

------------------------
---- Tab management ----
------------------------
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-------------------
---- Telescope ----
-------------------
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
