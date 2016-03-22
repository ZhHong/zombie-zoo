local CCBTools = {}

function CCBTools.deepCopy(dst, obj)
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

function CCBTools.c3b_c4b(color3B)
    return cc.c4b(color3B.r, color3B.g, color3B.b, 255)
end

function CCBTools.delayCall(delay, call, ...)
    local delayTime = cc.DelayTime:create(delay)
    local args = {...}
    local callfunc = cc.CallFunc:create(function()
        if call and type(call) == 'function' then
            return call(unpack(args))
        end
    end)
    return cc.Sequence:create(delayTime, callfunc)
end

return CCBTools