class_name Mover
extends Node

@onready var char = get_parent()
@onready var tileMap :TileMap
@onready var animator = get_node_or_null("../AnimatedSprite2D")
@onready var jumpSound = get_node_or_null("../JumpSound")
@onready var landSound = get_node_or_null("../LandSound")

@export var moveSpeed = 1.5
@export var jumpHeight = 32

var animatorYoffset
var animationStand = "down_stand"
var animationJump = "down_jump"

enum MOVING_STATE {standing, jumping}
var movingState : MOVING_STATE

var targetGlobalPosition : Vector2

@onready var player = get_tree().get_first_node_in_group("PlayerCharacter")

func _ready():
	#get_parent().reparent(get_tree().root)
	movingState = MOVING_STATE.standing
	animatorYoffset =  animator.offset.y
	tileMap = GameManager.tilemap
	
func move(direction: Vector2):
	set_animation_names(direction)
	
	# only allow entity to move is it's not already moving
	if movingState == MOVING_STATE.jumping:
		return
		
	# get current tile 
	var currentTile: Vector2i = tileMap.local_to_map(char.global_position) 
	
	# get target tile
	var targetTile: Vector2i = Vector2i(
		currentTile.x + direction.x,
		currentTile.y + direction.y
	)
	
	# get data to see if the char should move or not
	var tileData : TileData = tileMap.get_cell_tile_data(0, targetTile)
	if tileData.get_custom_data("blockAll") == true:
		return
	elif tileData.get_custom_data("blockPlayer") == true && get_parent().name.begins_with("Player"):
		return
		
	# move char
	movingState = MOVING_STATE.jumping;
	targetGlobalPosition = tileMap.map_to_local(targetTile)
	tween_jump()
	
	# play the jump animation
	animator.play(animationJump)
	
	# play jump sound
	if jumpSound != null:
		jumpSound.play()

func _physics_process(delta):
	# If entity is not moving, return this function
	if movingState == MOVING_STATE.standing:
		return
		
	# if char is moving but has reached their destination, stop and return
	if char.global_position == targetGlobalPosition:
		
		movingState = MOVING_STATE.standing;
		
		#play the landing sound (if there is one)
		if landSound != null:
			landSound.play()
			 
		# play the standing animation
		animator.play(animationStand)
		return
	
	char.global_position = char.global_position.move_toward(targetGlobalPosition, moveSpeed)

func set_animation_names(direction: Vector2):

	match direction:
		Vector2.UP:
			animationStand = 'up_stand'
			animationJump = 'up_jump'
		Vector2.DOWN:
			animationStand = 'down_stand'
			animationJump = 'down_jump'
		Vector2.LEFT:
			animationStand = 'left_stand'
			animationJump = 'left_jump'
		Vector2.RIGHT:
			animationStand = 'right_stand'
			animationJump = 'right_jump'
			
func tween_jump():
	var tween = create_tween()
	tween.tween_property(animator, "offset", Vector2(0, animatorYoffset - jumpHeight), .27/moveSpeed)
	tween.tween_property(animator, "offset", Vector2(0, animatorYoffset),  .27/moveSpeed)

func _on_body_entered(body: StaticBody2D) -> void:
	print(body)
