extends TextureButton


# Called when the node enters the scene tree for the first time.
func _pressed() -> void:
	Global.boss_health = 350
	
	EthnicCleasing.flashbangyourmom(1.0)
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	
	
