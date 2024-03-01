---@param path string
---@return string?
local function template_filetype(path, bufnr)
    print('hello?')
    local root = vim.fn.fnamemodify(path, ':r')
    return vim.filetype.match { buf = bufnr, filename = root }
end

vim.filetype.add {
    extension = {
        vert = 'glsl',
        frag = 'glsl',
        wgsl = 'wgsl',
        qml = 'qmljs',
        gltf = 'json',
        cppm = 'cpp',
        inc = 'c',
        include = 'cpp',
        lds = 'ld',
        ldS = 'ld',

        tmpl = template_filetype,
        ['in'] = template_filetype,
    },
    filename = {
        ['dkms.conf'] = 'sh',
    },
}
