class_name ReparentToRoot
extends Node

func _on_timer_timeout():
	get_parent().reparent(get_tree().root)
