local utils = require "app.statics.utils"

local room_select_scene = class("room_select_scene", function(...)
		return display.newScene(...)
	end)

local function preload()
	cc.SpriteFrameCache:getInstance():addSpriteFrames("images/ui.plist")
end

function room_select_scene:ctor(rooms)
	print_r(rooms)
	preload()

	local node, children, seq = GAME.ccb.load("ccb/room_select_scene.json")
	self:addChild(node)

	print_r(children)
	local function set_list()
		local listView = children.room_list
		local cell = "ccb/" .. listView.options.cell .. ".json"
		for i = 1, #rooms do
	        local item = listView:newItem()
	        local content = GAME.ccb.load(cell)
	        item:addContent(content)
	        item:setItemSize(content:getContentSize().width, content:getContentSize().height + 10)
	        listView:addItem(item)
    	end
    	listView:reload()
	end

	set_list()
end

return room_select_scene	