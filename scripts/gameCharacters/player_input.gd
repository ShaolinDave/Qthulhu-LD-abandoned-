class_name PlayerInput
extends Node

@onready var mover = get_node_or_null("../Mover")

func _process(delta):
	if Input.is_action_pressed("up"):
		mover.move(Vector2.UP)
	elif Input.is_action_pressed("down"):
		mover.move(Vector2.DOWN)
	elif Input.is_action_pressed("left"):
		mover.move(Vector2.LEFT)
	elif Input.is_action_pressed("right"):
		mover.move(Vector2.RIGHT)
