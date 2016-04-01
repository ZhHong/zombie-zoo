local bullet = class("bullet", function()
		return display.newNode()
	end)

function bullet:ctor()
	local b = display.newSprite("#bullet_1.png")
	self:addChild(b)
end


return bullet