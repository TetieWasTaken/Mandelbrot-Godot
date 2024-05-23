extends Sprite2D

@export var zoom : float = 0.4
@export var m_offset : Vector2 = Vector2(-0.7, 0.0)
@export var max_iterations : int = 300
@export var scrolling_speed : float = 0.5
@export var data_label : Label

@export var zoom_speed : float = 2.0
@onready var zoom_target : float = zoom

func rtd(num : float, digit : int) -> float:
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func vrtd(vec : Vector2, digit : int) -> Vector2:
	return Vector2(rtd(vec.x, digit), rtd(vec.y, digit))

func _process(delta : float) -> void:
	material.set("shader_parameter/zoom", zoom)
	material.set("shader_parameter/offset", m_offset)
	material.set("shader_parameter/max_iterations", max_iterations)

	if Input.is_action_pressed("zoom_out"):
		zoom_target -= 1.02 * delta * zoom
	elif Input.is_action_pressed("zoom_in"):
		zoom_target += 1.02 * delta * zoom
	
	if Input.is_action_just_pressed("iter_up"):
		max_iterations += 10
	elif Input.is_action_just_pressed("iter_down"):
		max_iterations -= 10

	zoom = move_toward(zoom, zoom_target, zoom_speed * delta * zoom)

	var direction : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		m_offset += direction * scrolling_speed * delta / zoom
	
	data_label.text = str("Iterations: ", max_iterations, "\nZoom: ", rtd(zoom, 2), "\nOffset: ", vrtd(m_offset, 2))

	var viewport_size : Vector2 = get_viewport_rect().size
	material.set("shader_parameter/viewport_size", viewport_size)
