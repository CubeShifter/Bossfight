extends Control

@onready var ethnic_cleasing: CanvasLayer = $"Ethnic Cleasing"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_main("Main")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_main(name:StringName):
	for child in get_children():	
		if not (child.name == StringName("BG") or child.name == StringName("Ethnic Cleasing") or child.name == name):
			child.visible = false
		else:
			
			child.visible = true
			
