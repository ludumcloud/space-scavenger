extends Node2D

var direction: Vector2
var rotation_speed: float

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var resourceType: String

func init(type: String, curPos: Vector2):
	resourceType = type
	self.global_position = curPos

	match type:
		"fuel":
			$Sprite.texture = load("res://assets/ssck/Blue (36).png")

	self.scale = Vector2(0.4, 0.4)

	direction = Vector2(rand_range(-2, 2), rand_range(-2, 2))
	rotation_speed = rand_range(-1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ship = get_parent().get_child(0)
	var distance = (ship.global_position - self.global_position).length()
	if distance < 100:
		get_parent().get_child(2).get_child(2).found_fuel()
		ship.add_resource(resourceType)
		get_parent().remove_child(self)

	#distance based cleanup
	if (distance > 4000):
		get_parent().remove_child(self)

	var updateVec = self.global_position * direction
	updateVec = updateVec.normalized() * delta * 25
	self.translate(updateVec)
	self.rotate(rotation_speed * delta)
