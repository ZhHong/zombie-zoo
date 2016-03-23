local game_layer = class("game_layer", function()
		return display.newNode()
	end)

local ACTOR_CAEMRA_FLAG = 2
function game_layer:ctor( )
	local actor = display.newSprite("#ghost_1.png")
	actor:setPosition(display.width/2, display.height/2)
	-- actor:setPosition(0, 0)
	self:addChild(actor)

	local camera = cc.Camera:createOrthographic(display.width, display.height, 0, 1)
	camera:setCameraFlag(ACTOR_CAEMRA_FLAG)
	self:addChild(camera)

	actor:setCameraMask(ACTOR_CAEMRA_FLAG)

	-- camera:setPosition(cc.p(200, 200))
	self:setNodeEventEnabled(true)
	self:setTouchEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
    	local x, y = event.x, event.y
    	local cx, cy = camera:getPosition()
    	if event.name == "began" then 
    		-- print(string.format("click x, y = %.2f, %.2f", x, y))
    		local p = self:convertToWorldSpace(cc.p(x, y))

    		local tx, ty = p.x + self.camera:getPositionX(), p.y + self.camera:getPositionY()

    		print(string.format("click = %.2f, %.2f, p = %.2f, %.2f, tx, ty = %.2f, %.2f",x, y, p.x, p.y, tx, ty))
    		actor:setPosition(tx, ty)
    		-- local world_x, world_y = p.x + cx, p.y + cy
    		-- print("node, x, y = ", world_x, world_y)
    	end

    	return true
    end)

    self:setContentSize(display.width*2, display.height*2)
    self.camera = camera
    self.actor = actor

    -- self.camera:runAction(cc.Follow:create(actor))
end

function game_layer:get_camera()
	return self.camera
end

function game_layer:get_actor()
	return self.actor
end

function game_layer:update()
	local ox, oy = self.actor:getPosition()
	self.camera:setPosition(ox - display.width/2, oy - display.height/2)
	-- ox,oy = self.camera:getPosition()
	-- self.camera:setPosition(ox + 1, oy)
end

return game_layer