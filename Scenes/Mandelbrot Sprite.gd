extends Sprite2D

@export var zoom : float = 0.4
@export var m_offset : Vector2 = Vector2(-0.7, 0.0)
@export var max_iterations : int = 300
@export var scrolling_speed : float = 0.5
@export var data_label : Label

@export var zoom_speed : float = 2.0
@onready var zoom_target : float = zoom

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

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		m_offset += direction * scrolling_speed * delta / zoom
	
	data_label.text = str("Iterations: ", max_iterations, "\nZoom: ", zoom, "\nOffset: ", m_offset)

	# Get the viewport size and set it to the shader
	var viewport_size = get_viewport_rect().size
	material.set("shader_parameter/viewport_size", viewport_size)
