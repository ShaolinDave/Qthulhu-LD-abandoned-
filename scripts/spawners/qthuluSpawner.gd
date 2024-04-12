class_name QthuluSpawner
extends Node2D

@export var qthuluToSpawn : Resource

func _ready():
	print("qthuluToSpawn=",qthuluToSpawn)
	# spawnQuthulhu()
	
func spawnQuthulhu():
	if qthuluToSpawn != null:
		var instance = qthuluToSpawn.instantiate()
		get_tree().root.add_child.call_deferred(instance)
		instance.global_position = get_parent().global_position
		queue_free()
