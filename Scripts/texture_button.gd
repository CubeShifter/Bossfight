extends TextureButton
class_name menu_switcher
@export var where_to: StringName
@onready var menu: Node = get_tree().current_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	menu = get_tree().current_scene
	
func _pressed() -> void:
	menu.set_main(where_to)
