extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CollComponent = preload("res://CollComponent.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var testComp = CollComponent.instance()
	testComp.init("hull", Vector2(500, 300))

	var testComp2 = CollComponent.instance()
	testComp2.init("wing", Vector2(300, 500))

	self.add_child(testComp)
	self.add_child(testComp2)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		$Ship.rotate(-PI * delta * $Ship.angularVelocity);
	if Input.is_action_pressed("ui_right"):
		$Ship.rotate(PI * delta * $Ship.angularVelocity);
	if Input.is_action_pressed("ui_up"):
		$Ship.translate(Vector2(cos($Ship.rotation), sin($Ship.rotation)) * 30.0 * delta);

