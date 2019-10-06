extends Node2D

var componentType: String
var componentName: String
var componentClass
var pos: Vector2
var velocity: float

var componentLibrary = {
	"doepfer-hull-left": {
		"type": "hull-left",
		"texture": "res://assets/ssck/Orange (2).png",
		"name": "Doepfer Hull (left)",
		"klass": preload("res://HullL.tscn")
	},
	"doepfer-hull-right": {
		"type": "hull-right",
		"texture": "res://assets/ssck/Orange (3).png",
		"name": "Doepfer Hull (left)",
		"klass": preload("res://HullR.tscn")
	},
	"bastl-hull-simple": {
		"type": "hull",
		"texture": "res://assets/ssck/Orange (28).png",
		"name": "Bastl Micro Hull",
		"klass": preload("res://Scaffold.tscn")
	},
	"doepfer-wing-left": {
		"type": "wing-left",
		"texture": "res://assets/ssck/Orange (14).png",
		"name": "Doepfer Wing (left)",
		"klass": preload("res://WingL.tscn")
	},
	"doepfer-wing-right": {
		"type": "wing-right",
		"texture": "res://assets/ssck/Orange (15).png",
		"name": "Doepfer Wing (Right)",
		"klass": preload("res://WingR.tscn")
	},
	"mutable-engine-left": {
		"type": "engine-left",
		"texture": "res://assets/ssck/Orange (6).png",
		"name": "Mutable Inc. Impulse Engine (Left)",
		"klass": preload("res://EngineAL.tscn")
	},
	"mutable-engine-right": {
		"type": "engine-right",
		"texture": "res://assets/ssck/Orange (7).png",
		"name": "Mutable Inc. Impulse Engine (Right)",
		"klass": preload("res://EngineAR.tscn")
	},
	"basimilus-engine-left": {
		"type": "engine-left",
		"texture": "res://assets/ssck/Orange (4).png",
		"name": "Basimilus Ram Scoop Engine (Left)",
		"klass": preload("res://EngineBL.tscn")
	},
	"basimilus-engine-right": {
		"type": "engine-right",
		"texture": "res://assets/ssck/Orange (5).png",
		"name": "Basimilus Ram Scoop Engine (Right)",
		"klass": preload("res://EngineBR.tscn")
	}
}

func init(componentKey: String, curPos: Vector2):
	var descriptor = componentLibrary[componentKey]
	componentType = descriptor['type']
	componentName = descriptor['name']
	componentClass = descriptor['klass']
	$Sprite.texture = load(descriptor['texture'])
	
	self.global_position = curPos
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
			# var attachPopup = get_parent().get_node('CanvasLayer/AttachmentPopup')
			# attachPopup.set_text(componentType, 10, 5, 80, 100)
			# attachPopup.popup()
			ship.do_attach(componentType, componentClass.instance())
			get_parent().remove_child(self)

	#distance based cleanup
	if (distance > 4000):
		get_parent().remove_child(self)

