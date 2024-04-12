class_name QthulhuSpawnerToGameManager
extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.qthulhuSpawner = get_parent()

func _on_body_entered(body: CharacterBody2D) -> void:
	print(body)
