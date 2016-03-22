local game_scene = class("game_scene", function()
		return display.newScene()
	end)

local ACTOR_CAEMRA_FLAG = 2
function game_scene:ctor()
	local function preload()
		cc.SpriteFrameCache:getInstance():addSpriteFrames("images/ui.plist")
		cc.SpriteFrameCache:getInstance():addSpriteFrames("images/ghost.plist")
	end

	preload()
	
	local bg_layer = require("app.layers.map_bg_layer").new()
	bg_layer:setCameraMask(2)
	local actor = display.newSprite("#ghost_1.png")
	actor:setPosition(display.width/2, display.height/2)

	local camera = cc.Camera:createOrthographic(display.width, display.height, 0, 1)
	camera:setCameraFlag(ACTOR_CAEMRA_FLAG)
	self:addChild(camera)

	self:addChild(actor)
	actor:setLocalZOrder(100)

	self:addChild(bg_layer)
	bg_layer:setLocalZOrder(-1)
	-- bg_layer:setVisible(false)
	
	actor:setCameraMask(ACTOR_CAEMRA_FLAG)


	bg_layer:runAction(cc.Follow:create(camera))

	-- camera:runAction(cc.Follow:create(actor))
	
	-- camera:setPosition(cc.p(display.width/2, display.height/2))

	self:setNodeEventEnabled(true)
	self:setTouchEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
    	local x, y = event.x, event.y
    	local cx, cy = camera:getPosition()
    	if event.name == "began" then
    		-- local p = 
    		print(string.format("click x, y = %.2f, %.2f", x, y))
    		local p = self:convertToNodeSpace(cc.p(x, y))

    		actor:runAction(cc.MoveTo:create(1, p))
    		-- local world_x, world_y = p.x + cx, p.y + cy
    		-- print("node, x, y = ", world_x, world_y)
    	end

    	return true
    end)


    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
    self:scheduleUpdate()

    self.camera = camera
end

function game_scene:update(dt)
	-- local ox, oy = self.camera:getPosition()
	-- self.camera:setPosition(ox + 1, oy+1)
end


return game_scene