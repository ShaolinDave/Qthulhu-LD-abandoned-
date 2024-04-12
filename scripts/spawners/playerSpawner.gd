class_name PlayerSpawner
extends Node2D

@export var playerToSpawn : Resource
 
func _ready():
	print("playerToSpawn=",playerToSpawn)	
	spawnPlayer()

func spawnPlayer(): 
	if playerToSpawn != null:
		var instance = playerToSpawn.instantiate()
		get_tree().root.add_child.call_deferred(instance)
		queue_free()
