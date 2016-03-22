local logger = {}


local log_level = "verbose"

-- OPTIONS
local log_options = "-t"

local spliter = " "

local g_print = print

function logger.print(...)
    if log_level == "verbose" then
        local prefix = ""
        if string.find(log_options, "-t") then
            prefix = prefix .. os.date("[%x %X]")
        end

        if string.find(log_options, "-l") then
            local traceback = string.split(debug.traceback("", 2), "\n")
            local location = string.trim(traceback[3])
            prefix = prefix .. location
        end

        g_print(prefix, spliter, ...)
    elseif log_level == "clean" then
        g_print(...)
    end
end

return logger