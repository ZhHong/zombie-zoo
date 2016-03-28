local consts = require "app.share.consts"

local game_handler = class("game_handler")

function game_handler:ctor()
	GAME.client:register_listener("player_room_action", handler(self, self.on_player_room_action))
	GAME.client:register_listener("player_state_action", handler(self, self.on_player_state_action))
end

function game_handler:on_player_room_action(msg)
	if msg.action_type == consts.player_room_action.player_enter then
		if self.ui then
			print("add the actor, new player goes here")
			self.ui:add_actor(msg.player_info)
		end
	elseif msg.action_type == consts.player_room_action.player_leave then
		if self.ui then
			self.ui:remove_actor(msg.player_info)
		end
	else
		assert(false, "invalid action.")
	end
end

function game_handler:on_player_state_action(msg)
	self.ui:update_actor(msg)
end

function game_handler:set_ui(ui)
	print('----set the ui here----')
	self.ui = ui
end


return game_handler