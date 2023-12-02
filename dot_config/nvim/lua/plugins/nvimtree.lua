return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = "NvimTreeToggle",
    keys = { { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "NvimTree" } },
    config = function()
        local function on_attach(bufnr)
            local api = require("nvim-tree.api")
            -- local Event = api.events.Event
            -- api.events.subscribe(
            --     Event.WillRemoveFile,
            --     -- Event.FileRemoved,
            --     ---@param data {fname: string}
            --     function(data)
            --         print("--------- event called")
            --         if data.fname:match("chezmoi") == nil then
            --             vim.notify("not in chezmoi")
            --             return
            --         end
            --         local source = data.fname:gsub(vim.env.HOME, "~")
            --         local target = vim.fn.system({ "chezmoi", "target-path", source }) ---@cast target string
            --         target = target:gsub(vim.env.HOME, "~")
            --         if vim.v.shell_error ~= 0 then
            --             vim.notify("Chezmoi target-path failed: " .. target)
            --             return
            --         end
            --         -- local result = vim.fn.system({ "chezmoi", "remove", "--force", target })
            --         vim.print(vim.fn.system("ls", target))
            --         local result = vim.fn.system({ "rm", target })
            --         if vim.v.shell_error == 0 then
            --             vim.notify("Chezmoi removed: " .. data.fname)
            --         else
            --             vim.notify("Chezmoi remove failed: " .. result)
            --         end
            --     end
            -- )

            -- local notify = require "nvim-tree.notify"
            --- Remove a node, notify errors, dispatch events
            --- @param node table
            -- function M.remove(node)
            --   local notify_node = notify.render_path(node.absolute_path)
            --   if node.nodes ~= nil and not node.link_to then
            --     local success = remove_dir(node.absolute_path)
            --     if not success then
            --       return notify.error("Could not remove " .. notify_node)
            --     end
            --     events._dispatch_folder_removed(node.absolute_path)
            --   else
            --     events._dispatch_will_remove_file(node.absolute_path)
            --     local success = vim.loop.fs_unlink(node.absolute_path)
            --     if not success then
            --       return notify.error("Could not remove " .. notify_node)
            --     end
            --     events._dispatch_file_removed(node.absolute_path)
            --     clear_buffer(node.absolute_path)
            --   end
            --   notify.info(notify_node .. " was properly removed.")
            -- end
            --

            local function remove(node)
                -- if in chezmoi, custom function
                -- else, return api.fs.remove(node)
            end

            local opts = function(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end
            -- stylua: ignore start
            -- open
            vim.keymap.set("n", "<CR>", api.node.open.edit,        opts("Open"))
            vim.keymap.set("n", "o", api.node.open.edit,           opts("Open"))
            vim.keymap.set("n", "l", api.node.open.edit,           opts("Open"))
            vim.keymap.set("n", "O", api.node.run.system,          opts("Open: System"))
            vim.keymap.set("n", "<C-t>", api.node.open.tab,        opts("Open: New Tab"))
            vim.keymap.set("n", "<C-v>", api.node.open.vertical,   opts("Open: Vertical Split"))
            vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
            vim.keymap.set("n", "<Tab>", api.node.open.preview,    opts("Open: Preview"))
            -- navigation
            vim.keymap.set("n", "j", api.node.navigate.parent_close,      opts("Close Directory"))
            vim.keymap.set("n", "K", api.node.navigate.sibling.last,      opts("Last Sibling"))
            vim.keymap.set("n", "H", api.node.navigate.sibling.first,     opts("First Sibling"))
            vim.keymap.set("n", ">", api.node.navigate.sibling.next,      opts("Next Sibling"))
            vim.keymap.set("n", "<", api.node.navigate.sibling.prev,      opts("Previous Sibling"))
            vim.keymap.set("n", "P", api.node.navigate.parent,            opts("Parent Directory"))
            vim.keymap.set("n", "[c", api.node.navigate.git.prev,         opts("Prev Git"))
            vim.keymap.set("n", "]c", api.node.navigate.git.next,         opts("Next Git"))
            vim.keymap.set("n", "]d", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
            vim.keymap.set("n", "[d", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
            vim.keymap.set("n", "+", api.tree.change_root_to_node,        opts("CD"))
            vim.keymap.set("n", "-", api.tree.change_root_to_parent,      opts("Up"))
            vim.keymap.set("n", "J", api.tree.change_root_to_node,        opts("CD"))
            vim.keymap.set("n", "L", api.tree.change_root_to_parent,      opts("Up"))
            -- file management
            vim.keymap.set("n", "a", api.fs.create,              opts("Create"))
            vim.keymap.set("n", "D", api.fs.trash,               opts("Trash"))
            vim.keymap.set("n", "d", api.fs.remove,              opts("Delete"))
            vim.keymap.set("n", "r", api.fs.rename,              opts("Rename"))
            vim.keymap.set("n", "e", api.fs.rename_basename,     opts("Rename: Basename"))
            vim.keymap.set("n", "<C-r>", api.fs.rename_sub,      opts("Rename: Omit Filename"))
            vim.keymap.set("n", "c", api.fs.copy.node,           opts("Copy"))
            vim.keymap.set("n", "x", api.fs.cut,                 opts("Cut"))
            vim.keymap.set("n", "p", api.fs.paste,               opts("Paste"))
            vim.keymap.set("n", "y", api.fs.copy.filename,       opts("Copy Name"))
            vim.keymap.set("n", "Y", api.fs.copy.relative_path,  opts("Copy Relative Path"))
            vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
            -- display
            vim.keymap.set("n", "q", api.tree.close,         opts("Close"))
            vim.keymap.set("n", "R", api.tree.reload,        opts("Refresh"))
            vim.keymap.set("n", "zr", api.tree.expand_all,   opts("Expand All"))
            vim.keymap.set("n", "zm", api.tree.collapse_all, opts("Collapse"))
            -- search
            vim.keymap.set("n", "s", api.tree.search_node,   opts("Search"))
            vim.keymap.set("n", "f", api.live_filter.start,  opts("Filter"))
            vim.keymap.set("n", "F", api.live_filter.clear,  opts("Filter Clear"))
            -- toggle
            vim.keymap.set("n", ".", api.tree.toggle_hidden_filter,    opts("Toggle Filter: Dotfiles"))
            vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
            vim.keymap.set("n", "?", api.tree.toggle_help,             opts("Help"))
            -- marks
            vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
            vim.keymap.set("n", "bmv", api.marks.bulk.move,  opts("Move Bookmarked"))
            vim.keymap.set("n", "m", api.marks.toggle,       opts("Toggle Bookmark"))

            -- stylua: ignore end
            vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
            vim.keymap.set("n", "!", api.node.run.cmd, opts("Run Command"))
            -- vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
            -- vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle Filter: No Buffer"))
            -- vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Filter: Git Clean"))
            -- vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Filter: Hidden"))
            -- vim.keymap.set("n", "O", api.node.open.no_window_picker,     opts("Open: No Window Picker"))
        end

        require("nvim-tree").setup({
            on_attach = on_attach,
            actions = { open_file = { quit_on_open = true } },
            update_focused_file = { enable = true },
            -- diagnostics = { enable = true },
            filters = { dotfiles = true },
            system_open = { cmd = "open" },
            trash = { cmd = "trash" },
            notify = { threshold = vim.log.levels.WARN },
            sync_root_with_cwd = true, -- changes the tree root dir on `DirChanged`
        })
    end,
}
