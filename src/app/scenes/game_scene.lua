local game_scene = class("game_scene", function()
		return display.newScene()
	end)

function game_scene:ctor()
	local function preload()
		cc.SpriteFrameCache:getInstance():addSpriteFrames("images/ui.plist")
		cc.SpriteFrameCache:getInstance():addSpriteFrames("images/ghost.plist")
	end

	preload()
	
	local bg_layer = require("app.layers.map_bg_layer").new()

	self:addChild(bg_layer, -1)

	local game_layer = require("app.layers.game_layer").new()
	self:addChild(game_layer)

	bg_layer:setCameraMask(2)
	game_layer:setCameraMask(2)

	self:setNodeEventEnabled(true)
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
	self:scheduleUpdate()

	self.game_layer = game_layer
end

function game_scene:update(dt)
	self.game_layer:update(dt)
end


return game_scene