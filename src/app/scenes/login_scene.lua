local login_scene = class("login_scene", function()
		return display.newScene()
	end)

local function preload()
	cc.SpriteFrameCache:getInstance():addSpriteFrames("images/ui.plist")
end

function login_scene:ctor()
	preload()

	local node, children, seq = GAME.ccb.load("ccb/login_scene.json")
	self:addChild(node)

	GAME.ccb.play(node, seq)
end

return login_scene