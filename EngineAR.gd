extends Component

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_up") && get_tree().get_root().get_child(0).get_child(0).fuel > 0.1:
		$CPUParticles2D.emitting = true
	else:
		$CPUParticles2D.emitting = false
