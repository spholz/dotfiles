(function_call
  name: (_) @_fn_name (#eq? @_fn_name "use")
  arguments: (arguments
    (table_constructor
      (field
        name: (identifier) @_field_ident (#eq? @_field_ident "config")
        value: (string content: _ @lua))))
)
