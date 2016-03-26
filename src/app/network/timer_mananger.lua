local timer = require "app.network.timer"
local scheduler = cc.Director:getInstance():getScheduler()

local timer_mananger = {}

local timers = {}
local update_handle
function timer_mananger.init()
	if not update_handle then
		update_handle = scheduler:scheduleScriptFunc(timer_mananger.update, 0, false)
	end
end

function timer_mananger.destory()
	if update_handle then
		self.stop_all()
		scheduler:unscheduleScriptEntry(update_handle)
	end
end

function timer_mananger.new_timer(...)
	local t = timer.new(...)
	timers[t] = t
end

function timer_mananger.stop(t)
	t:stop()
	if timers[t] then
		timers[t] = nil
	else
		print("timer has already been stopped?")
	end
end

function timer_mananger.stop_all()
	for k,v in pairs(timers) do
		t:stop()
	end
	tiemrs = {}
end

function timer_mananger.update(dt)
	for k,v in pairs(timers) do
		v:update(dt)
	end
end

return timer_mananger