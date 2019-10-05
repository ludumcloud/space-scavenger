extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CollComponent = preload("res://CollComponent.tscn")

func generate_collectible_component():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	var testComp = CollComponent.instance()
	testComp.init("hull", Vector2(500, 300))

	var testComp2 = CollComponent.instance()
	testComp2.init("wing", Vector2(300, 500))
	
	var testComp3 = CollComponent.instance()
	testComp3.init("engine-a-l", Vector2(200, 500))

	var testComp4 = CollComponent.instance()
	testComp4.init("engine-a-r", Vector2(250, 500))

	var testComp5 = CollComponent.instance()
	testComp5.init("engine-b-l", Vector2(200, 600))

	var testComp6 = CollComponent.instance()
	testComp6.init("engine-b-r", Vector2(250, 600))

	self.add_child(testComp)
	self.add_child(testComp2)
	self.add_child(testComp3)
	self.add_child(testComp4)
	self.add_child(testComp5)
	self.add_child(testComp6)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		$Ship.rotate(-PI * delta * $Ship.angularVelocity);
	if Input.is_action_pressed("ui_right"):
		$Ship.rotate(PI * delta * $Ship.angularVelocity);
	if Input.is_action_pressed("ui_up"):
		$Ship.translate(Vector2(cos($Ship.rotation), sin($Ship.rotation)) * 30.0 * delta);

