local M = {}

---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts_ table
---@param description string
M.map_with_desc = function(mode, lhs, rhs, opts_, description)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('error', opts_, { desc = description }))
end

return M
