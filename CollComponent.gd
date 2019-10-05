extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var componentType: String
var pos: Vector2

func init(cType: String, curPos: Vector2):
	componentType = cType
	self.global_position = curPos

	match cType:
		"wing":
			$Sprite.texture = load("res://assets/ssck/Orange (14).png")
		"hull":
			$Sprite.texture = load("res://assets/ssck/Orange (2).png")

	self.scale = Vector2(0.5, 0.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ship = get_parent().get_child(0)
	if (ship.global_position - self.global_position).length() < 80:
		if(ship.can_attach(componentType)):
			ship.do_attach(componentType)
			get_parent().remove_child(self)

