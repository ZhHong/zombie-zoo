local proto = {}

local types = [[

.package {
    type        0 : integer
    session     1 : integer
}

]]

local c2s = [[
    login 1 {
        request {
            uuid  0 : string
        }
        response {
            error 0 : integer   # see the error code description
        }
    }

]]

local s2c = [[
   
]]

proto.c2s = types .. c2s
proto.s2c = types .. s2c

return proto