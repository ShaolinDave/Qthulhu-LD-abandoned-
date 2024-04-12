class_name TilemapToGameManager
extends Node

func _ready():
	GameManager.tilemap = get_parent()
