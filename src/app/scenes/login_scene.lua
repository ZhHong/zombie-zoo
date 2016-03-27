local utils = require "app.statics.utils"
local login_handler = require ("app.handlers.login_handler")

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

	local handler
	local function login(uuid)
		if not handler then
			handler = login_handler.new(uuid)
		end
		handler:login()
	end

	utils.set_ctrl_btn(children.btn_1p, function()
			login("uuid_1p")
		end)

	utils.set_ctrl_btn(children.btn_2p, function()
			login("uuid_2p")
		end)

end

return login_scene	