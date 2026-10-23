extends Sprite2D
@export var enemy : Node2D
#we can just add more nodes and do the plumage strat to the player for more weapons


func _process(delta: float) -> void:
	pass

func damage(amount : int):
	get_parent().playerhp -= amount
