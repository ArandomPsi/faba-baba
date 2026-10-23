extends Node2D
class_name weapon

@export var basecooldown : float = 1 #base cooldown
@export var cooldownmult : float = 1 #multiply to cooldown
@export var damage : int = 5
@export var damagemult : float = 1

func attack():
	get_parent().enemy.damage(damage * damagemult)
