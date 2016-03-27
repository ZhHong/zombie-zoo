local consts = {
	room = {
		open = 0,
		close = 1,
		lock = 2,
		player_limit = 8,
	},

	player_room_action = {
		player_enter = 1,
		player_leave = 2,
	},

	player_state_action = {
		move = 1,
		cast = 2,
		die = 3,
	}
}


return consts