local consts = require "app.share.consts"

local game_layer = class("game_layer", function(...)
		return display.newNode(...)
	end)

local function tile_to_screen(x, y)
	return display.width/2 + x * display.width, display.height/2 + y*display.height
end

local function add_actor_from_player(self, msg)
	local player = msg.player_info
	local actor = display.newSprite(string.format("#ghost_%d.png", msg.player_info.seq))
	local x, y = tile_to_screen(player.pos.x, player.pos.y)
	actor:setPosition(x, y)
	self:addChild(actor)
	actor:setCameraMask(ACTOR_CAEMRA_FLAG)
	self.actors[player.uuid] = actor
	actor.player = player

	local cur_id = GAME:get_player():get_uuid()
	if player.uuid == cur_id then
		self.player_actor = actor
	end

	return actor
end

local function enter_room(self, room_id)
	self.handler = require("app.handlers.game_handler").new(self)
	GAME.client:call_remote("player_enter_room", {room_id = room_id}, function(msg)
			if msg.err == 0 then
				print("entered the room.")
			else
				-- TODO: process the error.
				assert(false, "not process error yet.")
			end
		end)
end

function game_layer:ctor(room_id)
	-- init the actors
	print("Create game_layer, room_id = ", room_id)

	self.actors = {}

	local camera = cc.Camera:createOrthographic(display.width, display.height, 0, 1)
	camera:setCameraFlag(ACTOR_CAEMRA_FLAG)
	self:addChild(camera)
    self.camera = camera

    enter_room(self, room_id)
   

	self:setNodeEventEnabled(true)
	self:setTouchEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
    	local x, y = event.x, event.y
    	if event.name == "began" then 

    		local p = self:convertToWorldSpace(cc.p(x, y))
    		local tx, ty = p.x + self.camera:getPositionX(), p.y + self.camera:getPositionY()

    		print("tx , ty = ", tx, ty)
    		--TODO: remember to check the coord, the position sync may go wrong.????
    		GAME.client:call_remote("player_upload_state", {
	    			sync_data = {
	    				action_type = consts.player_state_action.move,
	    				coord = { x = math.floor(tx), y = math.floor(ty) }
	    			}
    			}, function() end)
    	end

    	return true
    end)

    self:setContentSize(display.width*2, display.height*2)
end

function game_layer:add_actor(msg)
	print('game_layer:add_actor player_uuid = ', msg.player_info.uuid)
	add_actor_from_player(self, msg)
end

function game_layer:remove_actor(msg)
	local player = msg.player_info
	print('game_layer:remove_actor player_uuid = ', player.uuid)
	self.actors[player.uuid]:removeFromParent()
	self.actors[player.uuid] = nil
end

function game_layer:update_actor(msg)
	local data = msg.sync_data
	if data.action_type == consts.player_state_action.move then
		local actor = self.actors[msg.player_info.uuid]
		-- TODO: here we should use ccmoveto..

		actor:runAction(cc.MoveTo:create(0.5, cc.p(data.coord.x, data.coord.y)))
		-- actor:setPosition(data.coord.x, data.coord.y)
	elseif data.action_type == consts.player_state_action.cast then
		
	elseif data.action_type == consts.player_state_action.die then

	else
		assert(false, "game_layer:update actor invalid action_type")
	end
end

function game_layer:get_camera()
	return self.camera
end

function game_layer:get_actor()

end

function game_layer:update()
	if self.player_actor then
		local ox, oy = self.player_actor:getPosition()
		local cx, cy = ox - display.width/2, oy - display.height/2
		cx = cx < 0 and 0 or cx
		cy = cy < 0 and 0 or cy

		cx = cx > display.width and display.width or cx
		cy = cy > display.height and display.height or cy
		
		self.camera:setPosition(cx, cy)
	end
end

return game_layer