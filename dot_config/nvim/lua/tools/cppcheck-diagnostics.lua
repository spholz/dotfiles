local namespace = vim.api.nvim_create_namespace 'cppcheck_diagnostics'

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
    pattern = '*.cpp,*.hpp,*.c,*.h',
    group = vim.api.nvim_create_augroup('cppcheck_diagnostics', { clear = true }),
    callback = function(event)
        local command = {
            'cppcheck',
            '--enable=all',
            '--project=compile_commands.json',
            '--template={line}ööö{column}ööö{severity}ööö{id}ööö{message}',
            event.match
        }

        local severities = {
            error = vim.diagnostic.severity.ERROR,
            warning = vim.diagnostic.severity.WARN,
            style = vim.diagnostic.severity.HINT,
            performance = vim.diagnostic.severity.WARN,
            portability = vim.diagnostic.severity.INFO,
            information = vim.diagnostic.severity.INFO,
        }

        local diagnostics = {}
        local stdout = ''

        vim.fn.jobstart(command, {
            stderr_buffered = true,
            on_stderr = function(_, data)
                for _, line in ipairs(data) do
                    if line == '' then
                        break
                    end

                    local linenr, column, severity, id, message =
                        string.match(line, '(%d+)ööö(%d+)ööö(%a+)ööö(%a+)ööö(.*)')

                    table.insert(diagnostics, {
                        lnum = tonumber(linenr) - 1,
                        col = tonumber(column),
                        severity = severities[severity],
                        message = message,
                        source = 'cppcheck',
                        code = id,
                    })
                end
            end,
            on_stdout = function(_, data)
                for _, line in ipairs(data) do
                    if line == '' then
                        break
                    end

                    stdout = stdout .. '\n' .. line
                end
            end,
            on_exit = function(_, exit_code)
                if exit_code ~= 0 then
                    vim.diagnostic.set(namespace, event.buf, { {
                        lnum = 0,
                        col = 0,
                        severity = vim.diagnostic.severity.ERROR,
                        message = stdout,
                        source = 'cppcheck',
                    } }, {})
                else
                    vim.diagnostic.set(namespace, event.buf, diagnostics, {})
                end
            end,
        })
    end,
})
