local stm = require "app.statics.state_machine"

local bullet = require "app.actors.bullet"

local actor = class("actor", function()
	return display.newNode()
end)

function actor:ctor(player)
	local sprite = display.newSprite(string.format("#ghost_%d.png", player.seq))

	print("typeof(actor) = ", type(actor))
	self:addChild(sprite)

	-- self.stm = stm.new  {
	-- 	init = "init",
	-- 	events = {
	-- 			{ name = "enter", from = "init", to = "active" },
	-- 			{ name = "move", from = {"active"}, to = "moving" },
	-- 			{ name = "cast", from = {"moving", "active"}, to = "casting" },
	-- 			{ name = "cast_fin", from = {"casting"}, to = "active" },
	-- 			{ name = "die",  from = {"active", "moving", "casting", to = "dead"}},
	-- 		},
	-- 	callbacks = { 
	-- 		on_enter = handler(self, self.on_enter),
	-- 		on_move = handler(self, self.on_move),
	-- 		on_cast = handler(self, self.on_cast),
	-- 		on_cast_fin = handler(self, self.on_cast_fin),
	-- 		on_die = handler(self, self.on_die),
	-- 	}
	-- }

	-- self.stm:attach(getmetatable(self))
end


function actor:fire(x, y)

	local target_world_p = self:getParent():convertToWorldSpace(cc.p(x, y))

	print("target_world_p = ", target_world_p.x, target_world_p.y)
	local bullet = bullet.new()
	local sx, sy = self:getPosition()
	local camera = self:getParent():get_camera()

-- case 1: remove camera
	target_world_p.x = target_world_p.x + camera:getPositionX()
	target_world_p.y = target_world_p.y + camera:getPositionY()

	bullet:setPosition(sx, sy)
	local dx, dy = target_world_p.x - sx, target_world_p.y - sy

	print("dx, dy = ", dx, dy)
	local move = cc.MoveBy:create(0.3, cc.p(dx, dy))

	local destroy = cc.CallFunc:create(function()
			bullet:removeFromParent()
		end)
	bullet:runAction(cc.Sequence:create({move, destroy}))

	bullet:setCameraMask(ACTOR_CAEMRA_FLAG)
	self:getParent():addChild(bullet)
end

function actor:on_enter()
	print("call actor:on_enter")
end

function actor:on_move()

end

function actor:on_cast()

end

function actor:on_cast_fin()

end

function actor:on_die()

end




return actor