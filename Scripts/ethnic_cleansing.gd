extends CanvasLayer
@onready var rect: ColorRect = $Rect

# Called when the node enters the scene tree for the first time.



func fade_in(speed):
	var tween = create_tween()

	tween.tween_property(
	rect.material, "shader_parameter/whiteness",1.0,2.0)
func fade_out(speed):
	var tween = create_tween()

	tween.tween_property(rect.material, "shader_parameter/whiteness",0.0,2.0)
	
func flashbangyourmom(speed):
	fade_in(speed)
	await get_tree().create_timer(speed).timeout
	
	fade_out(speed)
	
	
