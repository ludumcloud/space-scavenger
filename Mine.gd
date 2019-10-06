extends Node2D

var isActive = false

func init(position: Vector2):
	self.global_position = position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setActive(newActive):
	isActive = newActive
	if (isActive):
		$AnimatedSprite.frame = 1
	else:
		$AnimatedSprite.frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ship = get_parent().get_child(0)
	if (ship.global_position - self.global_position).length() < 100:
		ship.reinit()
		get_parent().remove_child(self)
