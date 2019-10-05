extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CollComponent = preload("res://CollComponent.tscn")
var CollResource = preload("res://CollResource.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var testComp = CollComponent.instance()
	testComp.init("hull", Vector2(500, 300))

	var testComp2 = CollComponent.instance()
	testComp2.init("wing", Vector2(300, 500))

	var testComp3 = CollComponent.instance()
	testComp3.init("hull", Vector2(500, 400))

	var testComp4 = CollComponent.instance()
	testComp4.init("hull", Vector2(500, 600))

	self.add_child(testComp)
	self.add_child(testComp2)
	
	var testResc = CollResource.instance()
	testResc.init("fuel", Vector2(100, 100))
	self.add_child(testResc)
	self.add_child(testComp3)
	self.add_child(testComp4)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		$Ship.rotate(-PI * delta * $Ship.angularVelocity);
	if Input.is_action_pressed("ui_right"):
		$Ship.rotate(PI * delta * $Ship.angularVelocity);
	if Input.is_action_pressed("ui_up"):
		$Ship.translate(Vector2(cos($Ship.rotation), sin($Ship.rotation)) * 30.0 * delta);

