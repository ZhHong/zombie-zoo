local login_scene = class("login_scene", function()
		return display.newScene()
	end)

function login_scene:ctor()
	print("load node")
	local node, children, seq = GAME.ccb.load("ccb/login_scene.json")
	print("load finished")
	self:addChild(node)

	local function opacity(f1, f2)
        local duration = f2.time - f1.time
        local to = f2.value
        print(string.format("f1 = %.2f, f2 = %.2f, to = %.2f, duration = %.2f", f1.value, f2.value, to, duration))
        return cc.FadeTo:create(duration, to)
    end

    local actions = {
    	opacity( {time = 0, value = 1*255}, {time = 1.5, value = 0.3*255} ),
		-- opacity( {time = 1.5, value = 0.3*255}, {time = 3, value = 1*255} ),
    }

    -- children.touch_label:runAction(cc.Sequence:create(actions))
	GAME.ccb.play(node, seq)
end

return login_scene