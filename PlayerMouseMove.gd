extends KinematicBody2D

#Setup
var cell_width = 128
onready var square = get_node("../square")
onready var line = get_node("../Line2D")

#Position & Movement Variables
enum STATE {IDLE, MOVE, ATTACK, ABILITY, ITEM}
var state
var curPos
var mousePos
var move_mode = false
var speed = 3
var move_dist
var slash_mode


func _ready():
	#Starting position of movement line & square
	line.add_point(get_position())
	line.add_point(get_position())
	line.set_visible(false)
	square.set_visible(false)
	
	#Set Player Start Position and Start State
	set_position(cell_center_pos(point_to_cell(Vector2(0,0))))
	state = IDLE
func _physics_process(delta):
	
	if state == IDLE:
		$State_Label.set_text('Idle')
	elif state == MOVE:
		$State_Label.set_text('Move')
	elif state == ATTACK:
		$State_Label.set_text('Attack')
	elif state == ABILITY:
		$State_Label.set_text('Ability')
	elif state == ITEM:
		$State_Label.set_text('Item')
	else:
		$State_Label.set_text('Other')
	
	
	
	if Input.is_action_just_pressed("ui_left"):
		player_stats.health += 1
		print(player_stats.health)
#player & mouse position updates	
	curPos = get_position()
	mousePos = get_global_mouse_position()
	
#Update the line and square indicator	
	update_line()
	update_square()
	
#Toggle Move Mode on & off	
	if Input.is_action_just_pressed("ui_accept") && state != MOVE:
		state = MOVE
		move_mode = true
	if Input.is_action_just_pressed("ui_cancel") && move_mode == true:
		move_mode = false
		state = IDLE
#Toggle Slash
	if Input.is_action_just_pressed("ui_up") && move_mode == false:
		slash_mode =  true
		state = ATTACK
	if Input.is_action_just_pressed("ui_cancel") && slash_mode == true:
		slash_mode = false
		state = IDLE
#Handle Move mode Logic
	if state == MOVE && Input.is_mouse_button_pressed(1):
		set_position(cell_center_pos(point_to_cell(mousePos)))
		move_mode = false
		state =  IDLE 
	if slash_mode == true && Input.is_action_just_pressed("ui_up"):
		slash()
		
		
func slash():
	var polyArray = []
	var pointArray = [Vector2(0,0),Vector2(128,0),Vector2(128,128),Vector2(0,128)]
	for i in range(3):
		polyArray.append(Polygon2D.new())
	for poly in polyArray:
		poly.set_polygon(pointArray)
		poly.set_position(cell_center_pos(curPos))
		add_child(poly)

func update_square():
#	print('updating square')
	if move_mode:
		square.set_visible(true)
	else:
		square.set_visible(false)
	square.set_position(point_to_cell(mousePos)*cell_width)

func update_line():
#	print('updating line')
	if move_mode:
		line.set_visible(true)
	else: 
		line.set_visible(false)
	line.set_point_position(0,curPos)
	line.set_point_position(1,mousePos)

func player_move():
		set_position(cell_center_pos(point_to_cell(mousePos)))
		move_mode = false
		state =  IDLE


# Converts Global Coordinate to cell positions
func point_to_cell(pos):	
	var cell = Vector2(int(pos.x/cell_width), int(pos.y/cell_width))
	return cell

# Converts Cell Coordinates to global coordinates located and the center of the cell
func cell_center_pos(cell):
	var x  = int(cell.x * cell_width) + (cell_width-1)/2
	var y = int(cell.y * cell_width) + (cell_width-1)/2
	return Vector2(x,y)
	