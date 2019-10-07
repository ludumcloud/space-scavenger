extends Component

# Called when the node enters the scene tree for the first time.
func _ready():
	joints.append(Component.make_joint(['hull'], get_node('./HullJoint')))
	joints.append(Component.make_joint(['hull-left', 'engine-left', 'wing-left'], get_node('./LeftJoint')))
	joints.append(Component.make_joint(['hull-right', 'engine-right', 'wing-right'], get_node('./RightJoint')))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
