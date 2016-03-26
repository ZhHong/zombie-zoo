local proto = {}

local types = [[

.package {
    type        0 : integer
    session     1 : integer
}

]]

local c2s = [[
    player_login 1 {
        request {
            uuid  0 : string
        }
        response {
            err 0 : integer
        }
    }

    player_enter_room 2 {
        request {
            room_id 0 :integer
        }
        response {
            err 0 :integer
        }
    }
 
]]

local s2c = [[
   
]]

proto.c2s = types .. c2s
proto.s2c = types .. s2c

return proto