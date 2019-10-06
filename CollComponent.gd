extends Node2D

var componentType: String

func init(cType: String, curPos: Vector2):
	componentType = cType
	self.global_position = curPos

	match cType:
		"wing-left":
			$Sprite.texture = load("res://assets/ssck/Orange (14).png")
		"wing-right":
			$Sprite.texture = load("res://assets/ssck/Orange (15).png")
		"hull":
			$Sprite.texture = load("res://assets/ssck/Orange (2).png")
		"engine-left":
			$Sprite.texture = load("res://assets/ssck/Orange (6).png")
		"engine-right":
			$Sprite.texture = load("res://assets/ssck/Orange (7).png")
		"engine-b-l":
			$Sprite.texture = load("res://assets/ssck/Orange (4).png")
		"engine-b-r":
			$Sprite.texture = load("res://assets/ssck/Orange (5).png")


	self.scale = Vector2(0.7, 0.7)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ship = get_parent().get_child(0)
	var distance = (ship.global_position - self.global_position).length()
	if (distance) < 80:
		if(ship.can_attach(componentType)):
			print("Can attach")
			var attachPopup = get_parent().get_node('CanvasLayer/AttachmentPopup')
			attachPopup.set_text(componentType, 10, 5, 80, 100)
			attachPopup.popup()
			ship.do_attach(componentType)
			get_parent().remove_child(self)

	#distance based cleanup
	if (distance > 4000):
		get_parent().remove_child(self)

