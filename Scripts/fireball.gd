extends Area2D

var vel := Vector2(0,0)
const SPEED = 400
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	position += vel*SPEED*delta
	rotation += deg_to_rad(720) * delta
	



func _on_body_entered(body: Node2D) -> void:
	queue_free()
