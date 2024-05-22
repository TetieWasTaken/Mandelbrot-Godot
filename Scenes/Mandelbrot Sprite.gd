extends Sprite2D

var zoom = 2.5
var m_offset = Vector2(0.26, 0.0)
var max_iterations = 100

@export var scrolling_speed : float = 1.0

func _process(delta : float) -> void:
	material.set("shader_parameter/zoom", zoom)
	material.set("shader_parameter/offset", m_offset)
	material.set("shader_parameter/max_iterations", max_iterations)
	
	if Input.is_action_just_pressed("zoom_out"):
		print("Zoom out")
		zoom *= 1.1
	elif Input.is_action_just_pressed("zoom_in"):
		print("Zoom in")
		zoom /= 1.1
	
	var direction = Input.get_vector("move_right", "move_left", "move_down", "move_up")
	if direction != Vector2.ZERO:
		m_offset += direction * scrolling_speed * delta
