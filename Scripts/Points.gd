extends MenuButton

@export var anim_time : float = 5

var points = [
	{
		"name": "seahorse vly",
		"offset": Vector2(-0.746, -0.117),
		"zoom": 25
	},
	{
		"name": "minibrot",
		"offset": Vector2(-1.765, 0),
		"zoom": 18
	},
	{
		"name": "miniminibrot",
		"offset": Vector2(-1.790024, 0),
		"zoom": 100000
	},
	{
		"name": "quad-spiral",
		"offset": Vector2(0.293, -0.483),
		"zoom": 40
	},
	{
		"name": "triple-spiral",
		"offset": Vector2(-0.099, -0.651),
		"zoom": 107
	},
	{
		"name": "claw valley",
		"offset": Vector2(-0.126, -0.84),
		"zoom": 320
	},
	{
		"name": "scepter vly",
		"offset": Vector2(-1.253, -0.03),
		"zoom": 60
	}
]

@onready var popup : PopupMenu = get_popup()
@onready var controller : Sprite2D = get_node("../Mandelbrot Sprite")

func _ready():
	popup.clear()
	for elem in points:
		popup.add_item(elem["name"])
	popup.index_pressed.connect(_popup_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _popup_pressed(index : int) -> void:
	if points[index] and not controller.is_animating:
		controller.is_animating = true
		controller.offset_target = points[index]["offset"]
		controller.zoom_target = points[index]["zoom"]
		
		var distance : float = controller.m_offset.distance_to(controller.offset_target)
		controller.offset_speed = (distance / anim_time)
		
		controller.zoom_t_speed = abs(controller.zoom - controller.zoom_target) / anim_time

func go_to_point() -> void:
	pass

func add_point(offset : Vector2, zoom : float, display_name : String):
	points.append({"name": display_name}) # etc..
