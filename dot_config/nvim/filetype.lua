vim.filetype.add {
    extension = {
        vert = 'glsl',
        frag = 'glsl',
        wgsl = 'wgsl',
        qml = 'qmljs',
        gltf = 'json',
        cppm = 'cpp',
        inc = 'c',
        lds = 'ld',
        ldS = 'ld',

        ---@param path string
        ---@return string?
        tmpl = function(path, bufnr)
            local root = vim.fn.fnamemodify(path, ':r')
            return vim.filetype.match { buf = bufnr, filename = root }
        end,
    },
    filename = {
        ['dkms.conf'] = 'sh',
    },
}
