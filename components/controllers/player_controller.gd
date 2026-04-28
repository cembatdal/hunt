class_name PlayerController
extends Node

@onready var actor: Actor = get_parent()

func _physics_process(_delta: float) -> void:
	if not actor.health_component.is_alive():
		return
		
	# Klavyeden yönleri alıp Actor'e veriyoruz
	actor.move_direction = Input.get_vector("west", "east", "north", "south")
	
	# Fareden hedefi alıp Actor'e veriyoruz
	actor.aim_position = actor.get_global_mouse_position()
	
	# Fareye tıklandı mı bilgisini Actor'e veriyoruz
	actor.wants_to_shoot = Input.is_action_pressed("left_click")
