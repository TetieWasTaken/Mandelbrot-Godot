extends Sprite2D

@export var zoom : float = 0.4
@export var m_offset : Vector2 = Vector2(-0.7, 0.0)
@export var max_iterations : int = 100
@export var scrolling_speed : float = 0.2

func _process(delta : float) -> void:
	material.set("shader_parameter/zoom", zoom)
	material.set("shader_parameter/offset", m_offset)
	material.set("shader_parameter/max_iterations", max_iterations)
	
	if Input.is_action_just_pressed("zoom_out"):
		print("Zoom out")
		zoom /= 1.1
	elif Input.is_action_just_pressed("zoom_in"):
		print("Zoom in")
		zoom *= 1.1
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		m_offset += direction * scrolling_speed * delta / zoom
