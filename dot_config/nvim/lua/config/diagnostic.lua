vim.diagnostic.config {
    underline = true,
    virtual_text = {
        source = 'if_many', -- show diagnostic source if more than one source is in the buffer
    },
    signs = true,
    float = true,
    update_in_insert = false,
    severity_sort = true,
}
