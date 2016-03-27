local proto = {}

local types = [[

.package {
    type        0 : integer
    session     1 : integer
}

.room_info {
    id     0 : integer
    status 1 : integer  # 0-open, 1-closed, 2-locked
    cur    2 : integer
    limit  3 : integer
    name   4 : string
}

.coord {
    x 0 :integer
    y 1 :integer    
}

.player_info {
    uuid 0 : string
    name 1 : string
    pos  2 : coord
}

]]

local c2s = [[
    player_login 1 {
        request {
            uuid  0 : string
        }
        response {
            err 0 : integer
            player_info 1 : player_info
        }
    }

    player_get_room_list 100 {
        request {
            server_id 0 : integer
        }
        response {
            err     0 : integer
            rooms   1 : *room_info
        }
    }

    player_enter_room 101 {
        request {
            room_id 0 : integer
        }
        response {
            err 0 : integer
            player_info 1 : *player_info(uuid)
        }
    }
 
]]

local s2c = [[
    player_room_action 1 {
        request {
            action_type 0 : integer  #check consts.player_room_action
            room_id     1 : integer
            player_info 2 : player_info  # TODO:add an actor once, we need more????
        }
        response {

        }
    }
]]

proto.c2s = types .. c2s
proto.s2c = types .. s2c

return proto