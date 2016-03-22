local class = class or require "class"
local stack = class("stack")

function stack:ctor()
	self._data = {}
	self._top = 0
	self._buttom = 0
end

function stack:push(val)
	local top = self._top
	top = top + 1
	self._data[top] = val
	self._top = top
end

function stack:top()
	return self._data[self._top]
end

function stack:pop()
	local ret = self._data[self._top]
	self._data[self._top] = nil
	self._top = self._top - 1
	return ret
end

function stack:size()
	return self._top - self._buttom
end

function stack:__tostring()
 	local t = {}
    for i = self._buttom, self._top do
        table.insert(t, self._data[i])
    end
    return table.concat(t, ',')
end


return stack