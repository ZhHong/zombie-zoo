local game_layer = class("game_layer", function(...)
		return display.newNode(...)
	end)

local function tile_to_screen(x, y)
	return display.width/2 + x * display.width, display.height/2 + y*display.height
end

local function add_actor_from_player(self, player)
	local actor = display.newSprite("#ghost_1.png")
	local x, y = tile_to_screen(player.pos.x, player.pos.y)
	actor:setPosition(x, y)
	print("x, y = ", x, y)
	self:addChild(actor)
	actor:setCameraMask(ACTOR_CAEMRA_FLAG)
	self.actors[player.uuid] = actor
	actor.player = player
	return actor
end

function game_layer:ctor(players, handler)
	-- init the actors
	handler:set_ui(self)
	self.handler = handler
	self.actors = {}
	local cur_id = GAME:get_player():get_uuid()

	for i, player in pairs(players) do
		local actor = add_actor_from_player(self, player)
		print("cur_id, player.uuid = ", cur_id, player.uuid)
		if cur_id == player.uuid then
			self.player_actor = actor
		end
		
	end

	local camera = cc.Camera:createOrthographic(display.width, display.height, 0, 1)
	camera:setCameraFlag(ACTOR_CAEMRA_FLAG)
	self:addChild(camera)
    self.camera = camera

	self:setNodeEventEnabled(true)
	self:setTouchEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
    	local x, y = event.x, event.y
    	if event.name == "began" then 

    		local p = self:convertToWorldSpace(cc.p(x, y))
    		local tx, ty = p.x + self.camera:getPositionX(), p.y + self.camera:getPositionY()

    		self.player_actor:runAction(cc.MoveTo:create(0.5, cc.p(tx, ty)))
    	end

    	return true
    end)

    self:setContentSize(display.width*2, display.height*2)
end

function game_layer:add_actor(player)
	print('game_layer:add_actor player_uuid = ', player.uuid)
	add_actor_from_player(self, player)
end

function game_layer:remove_actor(player)
	print('game_layer:remove_actor player_uuid = ', player.uuid)
	actors[player.uuid]:removeFromParent()
	actors[player.uuid] = nil
end

function game_layer:get_camera()
	return self.camera
end

function game_layer:get_actor()

end

function game_layer:update()
	local ox, oy = self.player_actor:getPosition()
	local cx, cy = ox - display.width/2, oy - display.height/2
	cx = cx < 0 and 0 or cx
	cy = cy < 0 and 0 or cy

	cx = cx > display.width and display.width or cx
	cy = cy > display.height and display.height or cy
	
	self.camera:setPosition(cx, cy)
end

return game_layer