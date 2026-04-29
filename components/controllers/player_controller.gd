class_name PlayerController
extends Node

@onready var actor: Actor = get_parent()

func _physics_process(_delta: float) -> void:
	if not actor.health_component.is_alive():
		return
		
	actor.move_direction = Input.get_vector("west", "east", "north", "south")
	actor.aim_position = actor.get_global_mouse_position()
	
	# 1. Elimizde bir silah var mı bakalım:
	var current_weapon = null
	if actor.weapon_holder.get_child_count() > 0:
		current_weapon = actor.weapon_holder.get_child(0)
		
	# 2. Silahı bulduysak ve datası (Resource) varsa atış mantığını kuralım:
	if current_weapon != null and current_weapon.data != null:
		
		# --- SENİN GÖREVİN BURADA BAŞLIYOR ---
		if current_weapon.data.is_automatic:
			# Silah otomatikse:
			actor.wants_to_shoot = Input.is_action_pressed("left_click")
		else:
			# Silah otomatik DEĞİLSE (Tek atış):
			actor.wants_to_shoot = Input.is_action_just_pressed("left_click")
