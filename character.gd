extends CharacterBody2D

var speed = 400.0

@export var bullet_scene: PackedScene 

@onready var muzzle = $Muzzle
@onready var camera = $Camera2D
@onready var shoot_sound = $ShootSound

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("west", "east", "north", "south")
	
	velocity = (direction * speed)
	
	look_at(get_global_mouse_position())
	move_and_slide()
	
	if Input.is_action_just_pressed("left_click"):
		fire()

func fire():
	if bullet_scene == null:
		return
		
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet) 
	bullet.global_transform = muzzle.global_transform
	
	shoot_sound.pitch_scale = randf_range(0.8, 1.2)
	
	shoot_sound.play()
