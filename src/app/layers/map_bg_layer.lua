local map_bg_layer = class("map_bg_layer", function()
		return display.newNode()
	end)

function map_bg_layer:ctor()
	local rects = { "unpack/rect_blue.png",
					"unpack/rect_green.png",
					"unpack/rect_orange.png", 
					"unpack/rect_red.png"}

    local pos = { {x = 0, y = 0}, {x = 1, y = 0}, {x = 0, y = 1}, {x = 1, y = 1}}
	for i = 1, #rects do
		local spr = display.newSprite(rects[i])
		spr:setScaleX(display.width/spr:getContentSize().width)
		spr:setScaleY(display.height/spr:getContentSize().height)
		local size = spr:getContentSize()
		local p = pos[i]
		spr:setPosition(display.width*p.x, display.height*p.y)
		spr:setAnchorPoint(cc.p(0, 0))
		self:addChild(spr)
	end
end
 
return map_bg_layer
