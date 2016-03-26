local skynet_client = require "app.network.skynet_client"
local proto = require "app.share.game_proto"
local stm = require "app.statics.state_machine"

local login_handler = class("login_handler")

function login_handler:ctor(uuid)
	self.uuid = tostring(assert(uuid))
	self.client = skynet_client.new(proto, "client")

	self.stm = stm.new {
		init = "init",
		events = {
				{ name = "login", from = "init", to = "connecting" },
				{ name = "fin", from = "connecting", to = "online" },
				{ name = "logout", from = "online", to = "offline" },
				{ name = "resume", from = "offline", to = "online" },
				{ name = "abort", from = {"online", "offline", "connecting"}, to = "init"},
			},
		callbacks = { 
			on_login = handler(self, self.on_login),
			on_logout = handler(self, self.on_logout),
			on_resume = handler(self, self.on_resume),
			on_abort = handler(self, self.on_abort),
		}
	}

	-- can this cold be cleaner????

	-- for k,v in pairs(self.stm.events) do
	-- 	print("v.name = ", v.name)
	-- 	local function_string = "return self.stm:" .. v.name .. "()"
	-- 	print("function_string = ", function_string)
	-- 	login_handler[v.name] = assert(loadstring(function_string))
	-- 	print("typeo f login_handler[v.name] = ", type(login_handler[v.name]))
	-- end
end

function login_handler:login()
	self.stm:login()
end

function login_handler:logout()
	self.stm:logout()
end

function login_handler:resume()
	self.stm:resume()
end

function login_handler:abort()
	self.stm:abort()
end

function login_handler:on_login()
	print("on_login")
	self.client:connect("127.0.0.1", 2000, function(event, msg)
			if event == "CONNECT" then
				if msg.ok then
					print("connected.")
				else
					print("connected error msg = ", msg.err)
				end

			elseif event == "DISCONNECT" then
				print("disconnect?")

			elseif event == "SEND" then

			elseif event == "RECEIVE" then

			else
				assert(false, "unknown event")
			end
		end)
end

function login_handler:on_logout()
	print("on_logout")
end

function login_handler:on_resume()
	print("on_resume")
end

function login_handler:on_abort()
	print("on_abort")
end

return login_handler