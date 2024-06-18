---@param path string
---@return string?
local function template_filetype(path, bufnr)
    local root = vim.fn.fnamemodify(path, ':r')
    return vim.filetype.match { buf = bufnr, filename = root }
end

vim.filetype.add {
    extension = {
        cppm = 'cpp',
        frag = 'glsl',
        gltf = 'json',
        inc = 'c',
        include = 'cpp',
        ldS = 'ld',
        lds = 'ld',
        ll = 'llvm',
        qml = 'qmljs',
        vert = 'glsl',
        wgsl = 'wgsl',

        tmpl = template_filetype,
        ['in'] = template_filetype,
    },
    filename = {
        ['dkms.conf'] = 'sh',
    },
}
