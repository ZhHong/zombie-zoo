local player = class("player")

function player:ctor(player_info)
	deepcopy(self, player_info)
end

function player:get_uuid()
	return self.uuid
end

return player