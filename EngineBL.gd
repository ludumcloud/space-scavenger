extends Component

func _ready():
	joints.append(Component.make_joint(['wing-left'], get_node('./WingLJoint')))
	joints.append(Component.make_joint(['engine-left', 'hull-left'], get_node('./EngineLJoint')))

func _process(delta):
	if Input.is_action_pressed("ui_up") && get_tree().get_root().get_child(0).get_child(0).fuel > 0.1:
		$CPUParticles2D.emitting = true
	else:
		$CPUParticles2D.emitting = false
