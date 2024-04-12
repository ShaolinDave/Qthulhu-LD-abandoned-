class_name PlayerToGameManager
extends Node

func _ready():
	GameManager.player = get_parent()
