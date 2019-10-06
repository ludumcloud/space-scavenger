extends Component

func _ready():
	joints.append(Component.make_joint(['wing-left'], get_node('./WingLJoint')))
	joints.append(Component.make_joint(['engine-left', 'hull-left'], get_node('./EngineLJoint')))
