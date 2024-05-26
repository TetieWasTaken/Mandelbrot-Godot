extends Sprite2D

var colours = ["default", "green", "red"]
var colour_index : int = 0

var is_animating : bool = false
var offset_speed : float
var zoom_t_speed : float

@export_group("Zoom")
@export var zoom : float = 0.4
@export var max_zoom : float = 100000.0
@export var zoom_speed : float = 2.0

@export_group("Offset")
@export var m_offset : Vector2 = Vector2(-0.7, 0.0)
@export var scrolling_speed : float = 0.5
@export var anim_time : float = 1.0

@export_group("Iterations")
@export var min_iterations : float = 10.0
@export var max_iterations : float = 500.0
@export var iterations : int = 300

@export var data_label : Label

@onready var zoom_target : float = zoom
@onready var offset_target : Vector2 = m_offset

@onready var base_zoom : float = zoom
@onready var mat : Material = material

func _ready() -> void:
	mat.set("shader_parameter/c_i", colour_index)

func rtd(num : float, digit : int) -> float:
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func vrtd(vec : Vector2, digit : int) -> Vector2:
	return Vector2(rtd(vec.x, digit), rtd(vec.y, digit))

func _process(delta : float) -> void:
	mat.set("shader_parameter/zoom", zoom)
	mat.set("shader_parameter/offset", m_offset)
	mat.set("shader_parameter/max_iterations", iterations)
	
	if not is_animating:
		if Input.is_action_pressed("zoom_out"):
			if zoom_target > base_zoom:
				zoom_target -= 1.02 * delta * zoom
		elif Input.is_action_pressed("zoom_in"):
			if zoom_target < max_zoom:
				zoom_target += 1.02 * delta * zoom
			else:
				zoom_target = max_zoom
		
		zoom = move_toward(zoom, zoom_target, zoom_speed * delta * zoom)
		
		var direction : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if direction != Vector2.ZERO:
			m_offset += direction * scrolling_speed * delta / zoom
	else:
		m_offset = m_offset.move_toward(offset_target, delta * offset_speed)
		zoom = move_toward(zoom, zoom_target, zoom_t_speed * delta)
		
		if m_offset == offset_target and zoom == zoom_target:
			is_animating = false
	
	if Input.is_action_just_pressed("iter_up"):
		if iterations < max_iterations:
			iterations += 10
	elif Input.is_action_just_pressed("iter_down"):
		if iterations > min_iterations:
			iterations -= 10
	
	if Input.is_action_just_pressed("cycle_colour"):
		colour_index += 1
		if colour_index == colours.size():
			colour_index = 0
		mat.set("shader_parameter/c_i", colour_index)

	data_label.text = str("Iterations: ", iterations, "\nZoom: ", rtd(zoom, 2), "\nOffset: ", vrtd(m_offset, 3), "\nColour: ", colours[colour_index])

	var viewport_size : Vector2 = get_viewport_rect().size
	mat.set("shader_parameter/viewport_size", viewport_size)
