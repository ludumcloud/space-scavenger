extends Component

func _ready():
	joints.append(Component.make_joint('wing-left', get_node('./WingLJoint')))
	joints.append(Component.make_joint('wing-right', get_node('./WingRJoint')))
	joints.append(Component.make_joint('engine-left', get_node('./EngineLJoint')))
	joints.append(Component.make_joint('engine-right', get_node('./EngineRJoint')))


