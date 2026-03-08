extends HSlider
@export var bus: StringName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus)))*10	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _value_changed(new_value: float) -> void:
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus),linear_to_db(new_value/10))
