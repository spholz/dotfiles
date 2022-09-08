if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    " glsl (OpenGL)
    au! BufRead,BufNewFile *.vert setfiletype glsl
    au! BufRead,BufNewFile *.frag setfiletype glsl

    " wgsl (WebGPU)
    au! BufRead,BufNewFile *.wgsl setfiletype wgsl

    " qml (Qt Quick)
    au! BufRead,BufNewFile *.qml setfiletype qmljs
augroup END
