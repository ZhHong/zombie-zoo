local tools = {}

function tools.deepcopy(dst, obj)
    assert (dst)
    assert (obj)
    local function copy(d, tv)
        for k,v in pairs(tv) do
            d[k] = v
        end
    end
    for k,v in pairs(obj) do
        if type(v) ~= "table" then
            dst[k] = v
        else
            dst[k] = {}
            copy(dst[k], v)
        end
    end
end

function tools.shallowcopy(dst, data)
    assert(dst)
    assert(data)
    if type(data) == 'table' then
        for k, v in pairs(data) do
            dst[k] = v
        end
    else -- number, string, boolean, etc
        dst = data
    end
    return dst
end

function tools.tnums(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

function tools.rotate_table(t)
    local ret = {}
    local function getlen(t)
        local len = 0
        for k,v in pairs(t) do
            if len == 0 then
                len = #v
            else
                if len ~= #v then
                    return nil
                end
            end
        end
        return len
    end

    local len = getlen(t)
    if len then
        for i = 1, len do
            ret[i] = {}
            for k, v in pairs(t) do
                ret[i][k] = t[k][i]
            end
        end
    else
        assert(false, "tools.rotate_table, invalid table format!")
    end
    return ret
end


function tools.split(str, pat)
    local tinsert = table.insert
    local t = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
        if s ~= 1 or cap ~= "" then
            tinsert(t,cap)
        end
        last_end = e+1
        s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
        cap = str:sub(last_end)
        tinsert(t, cap)
    end
    return t
end

function tools.str2table(str, split_char)
    local data = tools.split(str, split_char)
    for i=1,#data do
        data[i] = tonumber(data[i])
    end
    return data
end

function tools.dashstring2table(str)
    return tools.str2table(str, '-')
end


function tools.shuffle(total, max)
    local max = max or total
    local base = {}
    local results = {}
    for i=1, total do
        base[i] = i
    end
    for i=1, max do
        local k = math.random(i, total)
        base[i], base[k] =  base[k],  base[i]
    end
    for i=1, max do
        results[i] = base[i]
    end
    return results
end

function tools.exports()
    deepcopy = tools.deepcopy
    tnums = tools.tnums
end

return tools