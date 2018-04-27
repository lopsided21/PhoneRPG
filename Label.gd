extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var player

func _ready():
	player = get_parent()

func _process(delta):
	if player.move_mode:
		set_text("Moving")
	else:
		set_text("Idle")