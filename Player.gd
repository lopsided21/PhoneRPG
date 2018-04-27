extends KinematicBody2D

var direction = Vector2()

#Direction Constants
const UP = Vector2(0,-1)
const RIGHT  = Vector2(1,0)
const DOWN = Vector2(0,1)
const LEFT = Vector2(-1,0)

var speed = 0
const MAX_SPEED = 400

var velocity = Vector2()
var mouse_pos
var cell

func _ready():
	pass


func _physics_process(delta):
	mouse_pos = get_global_mouse_position()
	cell = mouse_pos/128 
	print(str(int(cell.x))+" "+str(int(cell.y)))
	var is_moving = Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left")
	
	direction = Vector2()
	
	if is_moving:
		speed = MAX_SPEED
		
		if Input.is_action_pressed("ui_up"):
			direction += UP
		elif Input.is_action_pressed("ui_right"):
			direction += RIGHT
		if Input.is_action_pressed("ui_down"):
			direction += DOWN
		elif Input.is_action_pressed("ui_left"):
			direction += LEFT
	else:
		speed = 0
	
	
	velocity = speed * direction * delta
	
	move_and_collide(velocity)