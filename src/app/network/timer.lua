local timer = {}

function timer.new(callback, interval, loop, name)
	assert(callback and type(callback) == 'function')
	assert(interval and interval >= 0)

	local o = {
		now = 0,
		callback = callback,
		interval = interval,
		loop = loop,
		name = name or "no_name_timer",

		stopped = false
	}

	setmetatable(o, {__index = timer})
	return o
end

function timer:run()
	if not self.stopped then
		return
	end

	self.stopped = false
end

function timer:stop()
	if self.stopped then
		return
	end

	self.stopped = true
end

function timer:is_stop()
	return self.stopped
end

function timer:update(dt)
	local now = self.now + dt
	if now >= interval then
		if loop > 0 then
			loop = loop - 1
			self.now = 0
		else
			self.stopped = true
		end
		self.callback()
	else
		self.now = now
	end
end

return timer