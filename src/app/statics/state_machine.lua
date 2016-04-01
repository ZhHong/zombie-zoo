--[[
Copyright (c) 2012 Kyle Conroy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

	inspired by: https://github.com/kyleconroy/lua-state-machine

	levelmax.root forked this and did a little hacking.

	NOTICE: state_machine:attach() may override your methods, 
		including function "is", function $events.name.
--]]

local state_machine = {}

function state_machine.new(conf)
	local obj = {}
	setmetatable(obj, {__index = state_machine})
	obj:ctor(conf)
	return obj
end

function state_machine:ctor(conf)
	self.init = conf.init
	self.events = conf.events
	self.callbacks = conf.callbacks

	assert(self.init and self.events)

	self.current = self.init

	local map = {}
	for k,v in pairs(conf.events)do
		map[v.name] = v
	end
	self.map = map

	local function transition(name)
		return function(self, ...)
			local ok, to = self:can(name)
			if ok then
				local from = self.current
				self.current = to
				local callback_name = "on_" .. name
				local callback = self.callbacks[callback_name]
				if callback then
					callback(self, from, to, ...)
				else
					assert(false, "callback should never be nil")
				end
			else
				error(string.format("can not do event %s at state %s", name, self.current))
			end
		end
	end

	for _, v in pairs(self.events) do
		local name = v.name
		self[name] = transition(name)
	end
end

function state_machine:can(name)
	local event = self.map[name]
	assert(event, string.format("unknown event name %s", name))

	if type(event.from) == "table" then
		for k,v in pairs(event.from) do
			if v == self.current then
				return true, event.to
			end
		end
		return false, event.to
	elseif type(event.from) == "string" then
		return event.from == self.current, event.to
	else
		assert(false, "invalid event.from, should be table or string")
		return false, event.to
	end
end

function state_machine:is(state)
	return self.current == state
end

function state_machine:get_state()
	return self.current
end

function state_machine:attach(target)
	assert(type(target) == 'table')
	for k,v in pairs(self.events) do
		local name = v.name
		target[name] = function(target, ...)
			return self[name](self, ...)
		end
	end

	local function attach_to(target, method_name)
		if not target[method_name] then
			target[method_name] = function(target, ...)
				return self[method_name](self, ...)
			end
		else
			assert(false, string.format("method %s has been used by the state machine, please change name.", method_name))
		end
	end

	attach_to(target, 'is')
	attach_to(target, 'get_state')
end

return state_machine