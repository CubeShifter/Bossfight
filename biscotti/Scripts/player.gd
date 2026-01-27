extends CharacterBody2D


const SPEED = 80
const JUMP_VELOCITY = -256
const GRAVITY = 512
const DASH_LENGTH = 256


var dashing:= false
var direction:= 1
var can_dash := true
var dash_refillable := false
var can_attack := true
var has_control := true
var attack_direction := ""
@onready var dashing_timer: Timer = $"Timers/Dashing"
@onready var dash_cooldown: Timer = $"Timers/Dash Cooldown"
@onready var attack: Area2D = $Attack
@onready var attack_timer: Timer = $Timers/Attack
@onready var attack_cooldown: Timer = $"Timers/Attack Cooldown"
@onready var control_regain: Timer = $"Timers/Control Regain"
@onready var hit_iframes: Timer = $"Timers/Hit Iframes"
@onready var hit_detector: Area2D = $"Hit Detector"


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		if dash_refillable:
			can_dash = true

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and has_control:
		velocity.y = JUMP_VELOCITY	
	elif Input.is_action_just_released("jump") and velocity.y <0 and has_control:
		velocity.y = 0
	elif Input.is_action_just_pressed("dash") and can_dash and has_control:
		dashing = true
		can_dash = false
		dash_refillable = false
		dash_cooldown.start()
		dashing_timer.start()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("left") and not dashing and has_control:
		velocity.x = -SPEED
		direction = -1
	elif Input.is_action_pressed("right") and not dashing and has_control:
		velocity.x = SPEED
		direction =1
	elif is_on_floor():
		velocity.x*= 0.8
	else:
		velocity.x *= 0.7
		
	if dashing:
		velocity =Vector2(direction*DASH_LENGTH,0)
		
	if Input.is_action_just_pressed("attack") and can_attack and has_control:
		attack.get_node("Collision").set_deferred("disabled",false)
		attack.visible = true
		can_attack = false
		attack_timer.start()
		attack_cooldown.start()
		if Input.is_action_pressed("up"):
			attack.position = Vector2(-6,-28)
			attack.rotation = 0
			attack_direction = "UP"
		elif Input.is_action_pressed("down") and not is_on_floor():
			attack.position = Vector2(-6,8)
			attack.rotation = 0
			attack_direction = "DOWN"
		else:
			attack.position = Vector2(14+14*direction-4,-6)
			attack.rotation = deg_to_rad(90)
			if direction ==1:
				attack_direction = "RIGHT"
			else:
				attack_direction = "LEFT"

	move_and_slide()
func _on_dashing_timeout() -> void:
	dashing = false


func _on_dash_cooldown_timeout() -> void:
	dash_refillable = true


func _on_attack_timeout() -> void:
	attack.get_node("Collision").set_deferred("disabled",true)
	attack.visible = false


func _on_attack_cooldown_timeout() -> void:
	can_attack = true






func _on_control_regain_timeout() -> void:
	has_control = true


func _on_hit_iframes_timeout() -> void:
	hit_detector.get_node("Collision").set_deferred("disabled",false)
	
func _on_hit_detector_area_entered(area: Area2D) -> void:
	hit_detector.get_node("Collision").set_deferred("disabled",true)
	velocity = Vector2(-600*direction,-120)
	dashing = false
	has_control = false
	control_regain.start()
	hit_iframes.start()
func hit():
	if attack_direction == "DOWN":
		velocity = Vector2(0,-150)
	elif attack_direction == "LEFT":
		velocity = Vector2(100,0)
	elif attack_direction == "RIGHT":
		velocity = Vector2(-100,0)
