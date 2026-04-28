class_name PlayerMoveState
extends State

func physics_update(_delta: float) -> void:
	var direction := Input.get_vector("west", "east", "north", "south")
	entity.velocity = direction * entity.speed
	entity.move_and_slide()
	entity.look_at(entity.get_global_mouse_position())

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		entity.fire()
	if event.is_action_pressed("roll"):  # İleride
		state_machine.transition_to("roll")
