class_name State
extends Node

var state_machine: StateMachine
var entity: Node  # owner entity

func enter() -> void:
	pass  # State başlarken

func exit() -> void:
	pass  # State bitince

func update(_delta: float) -> void:
	pass  # _process

func physics_update(_delta: float) -> void:
	pass  # _physics_process

func handle_input(_event: InputEvent) -> void:
	pass  # _unhandled_input
