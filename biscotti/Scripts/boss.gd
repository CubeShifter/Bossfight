extends CharacterBody2D

const SLASH = preload("res://Scenes/slash.tscn")
const SHOCKWAVE = preload("res://Scenes/shockwave.tscn")
@onready var hit_detector: Area2D = $"Hit Detector"
@onready var rect: ColorRect = $Rect
@onready var player: CharacterBody2D = get_parent().get_node("player")
@onready var flash: Timer = $Flash
@onready var dive_wait: Timer = $"Dive Wait"
@onready var projectiles: Node2D = $"../Projectiles"
@onready var collision: CollisionShape2D = $Collision

@export var delay := 0.0
var direction := 0
enum states {WAITING,DIVE,DIVING,DASHING,SLASHING}
var state = states.WAITING
const DASH_SPEED = 512
 

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if Input.is_action_just_pressed("attack1") and state == states.WAITING:
		var t = randi_range(1,3)
		print(t)
		await get_tree().create_timer(delay).timeout
		if t == 1:
			dive()
		elif t == 2:
			dash() 
		elif t == 3:
			slash() 
	elif Input.is_action_just_pressed("a2"):
		net(2.0)
		await get_tree().create_timer(2.5).timeout
		net(1.5)
	
	if state == states.DIVE:
		velocity =  Vector2(0,640)
		if is_on_floor():
			state = states.WAITING
			velocity = Vector2.ZERO
			spawn_shockwave()
			
	elif state == states.DIVING:
		position.x = player.position.x
	elif state == states.DASHING:
		velocity.x = DASH_SPEED*direction
		if direction ==1 and position.x >140:
			state = states.WAITING

			velocity = Vector2.ZERO
		elif direction ==-1 and position.x <-140:
			state = states.WAITING
			velocity = Vector2.ZERO
	elif state == states.SLASHING :
		if position.y >120:
			velocity = Vector2.ZERO
			state = states.WAITING
			collision.set_deferred("disabled",false)
		
		
		
	
	
	

	# Handle jump.
	

	
	
	
	move_and_slide()


func _on_hit_detector_area_entered(area: Area2D) -> void:
	
	rect.color = Color(1,1,1)
	player.hit()
	flash.start()
	
	


func _on_flash_timeout() -> void:
	rect.color = Color(0,0,1)
func dive():
	position =Vector2(player.position.x,-64)
	state = states.DIVING
	await get_tree().create_timer(0.5).timeout
	state = states.DIVE
func dash():
	direction  =player.position.x / abs(player.position.x)
	if direction == 0:
		direction = randi_range(0,1)*2-1
	position = Vector2(-140*direction,69)
	await get_tree().create_timer(0.5).timeout
	state = states.DASHING
	
	
func slash():
	velocity = Vector2.ZERO
	if player.position.x > 64:
		position = Vector2(max(min(player.position.x -128,140),-140),-20)
	elif player.position.x < -64:
		position = Vector2(max(min(player.position.x +128,140),-140),-20)
	else:
		position = Vector2(max(min(player.position.x +(randi_range(0,1)*2-1)*128,140),-140),-20)
	await get_tree().create_timer(0.5).timeout
	state = states.SLASHING
	velocity = (player.position-position).normalized()*640
	collision.set_deferred("disabled",true)
	
	
func spawn_shockwave():
	await get_tree().create_timer(0.1).timeout
	var shockwave = SHOCKWAVE.instantiate()
	shockwave.position =Vector2(position.x,82)
	projectiles.add_child(shockwave)

func net(delay):
	var v = range(-3,4)
	
	var h = range(-1,2)
	#h.remove_at(randi_range(0,5))
	
	
	
	for i in v:
		var slash = SLASH.instantiate()
		slash.delay = delay
		slash.position.x = 40*i
		print(15*i)
		
		projectiles.add_child(slash)
		
	for i in h:
		var slash = SLASH.instantiate()
		slash.delay = delay
		slash.horizontal = true
		slash.position.y = 70*i
		projectiles.add_child(slash)
	
	
	
