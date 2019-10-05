extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		$Ship.rotate(-PI * delta);
	if Input.is_action_pressed("ui_right"):
		$Ship.rotate(PI * delta);
	if Input.is_action_pressed("ui_up"):
		$Ship.translate(Vector2(cos($Ship.rotation), sin($Ship.rotation)) * 30.0 * delta);
		
