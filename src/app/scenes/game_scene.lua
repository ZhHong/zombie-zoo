local game_scene = class("game_scene", function()
		return display.newScene()
	end)

local function preload()
	cc.SpriteFrameCache:getInstance():addSpriteFrames("images/ui.plist")
end

function game_scene:ctor()
	preload()
	
	local bg_layer = require("app.layers.map_bg_layer").new()
	self:addChild(bg_layer)

	local 
end


return game_scene