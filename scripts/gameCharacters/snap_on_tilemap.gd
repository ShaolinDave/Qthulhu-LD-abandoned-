class_name SnapOnTilemap
extends Node

@onready var parent = get_node_or_null("..")

func _ready():
	var tileMap = GameManager.tilemap
	parent.global_position = tileMap.map_to_local(tileMap.local_to_map(parent.global_position))
