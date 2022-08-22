if exists('b:current_syntax')
    finish
endif

syn match qfFileName  /^[^:]*/   nextgroup=qfSeparator
syn match qfSeparator /:/        nextgroup=qfLineColNr nextgroup=qfText contained
syn match qfLineColNr /[0-9\-]*/ nextgroup=qfSeparator contained
syn match qfText      /.*/       contained

hi def link qfFileName  Directory
hi def link qfSeparator Delimiter
hi def link qfLineColNr NonText
hi def link qfText      Normal

let b:current_syntax = 'qf'
