extends MenuButton

var points = [
	{
		"Name": "seahorse vly",
		"offset": Vector2(-0.746, -0.117),
		"zoom": 25
	}
]

@onready var popup : PopupMenu = get_popup()
@onready var controller : Sprite2D = get_node("../Mandelbrot Sprite")

func _ready():
	popup.clear()
	for elem in points:
		popup.add_item(elem["Name"])
	popup.index_pressed.connect(_popup_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _popup_pressed(index : int) -> void:
	if points[index]:
		print("Pressed")
		print(points[index])
		controller.offset_target = points[index]["offset"]
		controller.zoom_target = points[index]["zoom"]

func go_to_point() -> void:
	pass

func add_point(offset : Vector2, zoom : float, display_name : String):
	points.append({"name": display_name}) # etc..
