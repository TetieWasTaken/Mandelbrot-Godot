extends Sprite2D

@export var zoom : float = 0.4
@export var m_offset : Vector2 = Vector2(-0.7, 0.0)
@export var max_iterations : int = 100
@export var scrolling_speed : float = 0.2

@export var zoom_speed : float = 1
@onready var zoom_target = zoom

func _process(delta : float) -> void:
	material.set("shader_parameter/zoom", zoom)
	material.set("shader_parameter/offset", m_offset)
	material.set("shader_parameter/max_iterations", max_iterations)
	
	if Input.is_action_pressed("zoom_out"):
		zoom_target -= 1.02 * delta * zoom
	elif Input.is_action_pressed("zoom_in"):
		zoom_target += 1.02 * delta * zoom
	
	zoom = move_toward(zoom, zoom_target, zoom_speed * delta * zoom)
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		m_offset += direction * scrolling_speed * delta / zoom
