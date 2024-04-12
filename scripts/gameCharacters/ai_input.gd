class_name AIInput
extends Node

@onready var char = get_parent()
@onready var mover = get_node_or_null("../Mover")
@export var thinkTimer = 0.5

enum STATE {wander, chasePlayer, avoidPlayer, wandering, holdChicken}
@export var state : STATE

func _ready():
	$ThinkTimer.set_wait_time(thinkTimer)
	
func _on_think_timer_timeout():
	mover.move(getMoveDirection())

func getMoveDirection():
	var possibleMovements = []
	match state:
		STATE.chasePlayer:
			if GameManager.player == null:
				return Vector2.ZERO
			if GameManager.player.global_position ==  char.global_position:
				return Vector2.ZERO
			if GameManager.player.global_position.y < char.global_position.y:
				possibleMovements.push_back(Vector2.UP)
			elif GameManager.player.global_position.y > char.global_position.y:
				possibleMovements.push_back(Vector2.DOWN)
			if GameManager.player.global_position.x < char.global_position.x:
				possibleMovements.push_back(Vector2.LEFT)
			elif GameManager.player.global_position.x > char.global_position.x:
				possibleMovements.push_back(Vector2.RIGHT)
		STATE.avoidPlayer:
			if GameManager.player.global_position ==  char.global_position:
				return Vector2.DOWN
			elif GameManager.player.global_position.y < char.global_position.y:
				possibleMovements.push_back(Vector2.DOWN)
			elif GameManager.player.global_position.y > char.global_position.y:
				possibleMovements.push_back(Vector2.UP)
			if GameManager.player.global_position.x < char.global_position.x:
				possibleMovements.push_back(Vector2.RIGHT)
			elif GameManager.player.global_position.x > char.global_position.x:
				possibleMovements.push_back(Vector2.LEFT)
		STATE.wander:
			possibleMovements.push_back(Vector2.UP)
			possibleMovements.push_back(Vector2.DOWN)
			possibleMovements.push_back(Vector2.LEFT)
			possibleMovements.push_back(Vector2.RIGHT)
		STATE.holdChicken:
			if GameManager.fire.global_position.y < char.global_position.y:
				possibleMovements.push_back(Vector2.UP)
			elif GameManager.fire.global_position.y > char.global_position.y:
				possibleMovements.push_back(Vector2.DOWN)
			if GameManager.fire.global_position.x < char.global_position.x:
				possibleMovements.push_back(Vector2.LEFT)
			elif GameManager.fire.global_position.x > char.global_position.x:
				possibleMovements.push_back(Vector2.RIGHT)
	return possibleMovements.pick_random()
