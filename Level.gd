extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CollComponent = preload("res://CollComponent.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var testComp = CollComponent.instance()
	testComp.init("wing", Vector2(500, 300))
	self.add_child(testComp)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		$Ship.rotate(-0.1);
	if Input.is_action_pressed("ui_right"):
		$Ship.rotate(0.1);
	if Input.is_action_pressed("ui_up"):
		$Ship.translate(Vector2(cos($Ship.rotation), sin($Ship.rotation)) * 1.1);
		
