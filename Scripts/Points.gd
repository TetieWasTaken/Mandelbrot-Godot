extends MenuButton

var points = []

func _ready():
	get_popup().id_pressed.connect(_popup_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _popup_pressed(index : int) -> void:
	print("Pressed")

func go_to_point() -> void:
	pass

func add_point(offset : Vector2, zoom : float, display_name : String):
	points.append({"name": display_name}) # etc..
