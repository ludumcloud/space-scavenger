extends Popup

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_text(highscore):
	var l1 = $ColorRect/line1
	var l2 = $ColorRect/line2
	var l3 = $ColorRect/line3
	l1.clear()
	l2.clear()
	l3.clear()
	
	l1.push_color(Color(255, 255, 255)) # white
	l1.add_text("Congratulations!")
	
	l2.push_color(Color(200, 200, 200))
	l2.add_text("You escaped!")
	
	l3.push_color(Color(200, 200, 200))
	l3.add_text("You had ")
	l3.push_color(Color(0, 255, 0))
	l3.add_text(str(highscore))
	l3.push_color(Color(255, 255, 255))
	l3.add_text(" mines chasing you")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
