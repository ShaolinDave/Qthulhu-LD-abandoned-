extends Node

@onready var timer = $Timer
@onready var audio = $quitSound

# Web player can't quit, so remove functionality here
func _ready():
	if OS.get_name() == 'HTML5':
		queue_free()
	
# start/stop the shutdown timer when esc is pressed/released
func _input(event):
	if event.is_action_pressed("escToQuit"):
		timer.start()
	elif event.is_action_released("escToQuit"):
		timer.stop()

# when timer finishes while esc is still being held down, play shutdown sound
func _on_timer_timeout():
	audio.play()
	
# when shutdown sound finishes, close the app
func _on_quit_sound_finished():
	get_tree().quit()
