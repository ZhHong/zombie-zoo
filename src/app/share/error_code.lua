local error_code = {
	invalid_route = 1,
	invalid_route_func = 2,
	room_is_full = 3,
}

local error_code_str = {
	[error_code.invalid_route] = "invalid route",
	[error_code.invalid_route_func] = "invalid route function",
	[error_code.room_is_full] = "room is full",
}

function error_code.stringfy(code)
	return error_code_str[code] or "unknown error code"
end

return error_code