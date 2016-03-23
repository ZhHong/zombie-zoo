local game_layer = class("game_layer", function()
		return display.newNode()
	end)

local ACTOR_CAEMRA_FLAG = 2
function game_layer:ctor( )
	local actor = display.newSprite("#ghost_1.png")
	actor:setPosition(display.width/2, display.height/2)
	self.actor = actor
	self:addChild(actor)

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

    		-- print(string.format("click = %.2f, %.2f, p = %.2f, %.2f, tx, ty = %.2f, %.2f",x, y, p.x, p.y, tx, ty))
    		actor:runAction(cc.MoveTo:create(0.5, cc.p(tx, ty)))
    	end

    	return true
    end)

    self:setContentSize(display.width*2, display.height*2)

    actor:setCameraMask(ACTOR_CAEMRA_FLAG)
end

function game_layer:get_camera()
	return self.camera
end

function game_layer:get_actor()
	return self.actor
end

function game_layer:update()
	local ox, oy = self.actor:getPosition()
	local cx, cy = ox - display.width/2, oy - display.height/2
	cx = cx < 0 and 0 or cx
	cy = cy < 0 and 0 or cy

	cx = cx > display.width and display.width or cx
	cy = cy > display.height and display.height or cy
	
	self.camera:setPosition(cx, cy)
end

return game_layer