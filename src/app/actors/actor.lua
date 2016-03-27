local stm = require "app.statics.state_machine"

local actor = class("actor", function()
	return display.newNode()
end)

function actor:ctor()

	self.stm = stm.new  {
		init = "init",
		events = {
				{ name = "enter", from = "init", to = "active" },
				{ name = "move", from = {"active"}, to = "moving" },
				{ name = "cast", from = {"moving", "active"}, to = "casting" },
				{ name = "cast_fin", from = {"casting"}, to = "active" },
				{ name = "die",  from = {"active", "moving", "casting", to = "dead"}},
			},
		callbacks = { 
			on_enter = handler(self, self.on_enter),
			on_move = handler(self, self.on_move),
			on_cast = handler(self, self.on_cast),
			on_cast_fin = handler(self, self.on_cast_fin),
			on_die = handler(self, self.on_die),
		}
	}

end




return actor