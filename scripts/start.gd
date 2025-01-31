extends StaticBody2D

@onready var spawn_pos = $SpawnPosition

func get_spawn_position():
	return spawn_pos.global_position
