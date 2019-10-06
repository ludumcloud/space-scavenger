extends Popup

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func close_and_unpause():
	self.hide()
	get_parent().get_parent().unpause()

func on_attach():
	print("AAATTAAACHED")
	close_and_unpause()
	
func on_scrap():
	print("SCRAAAAAPPEEDD")
	close_and_unpause()

# Called when the node enters the scene tree for the first time.
func _ready():
	#self.set_exlusive(true)
	$ColorRect/AttachButton.connect("pressed", self, "on_attach")
	$ColorRect/ScrapButton.connect("pressed", self, "on_scrap")
	
	
	
	#pass # Replace with function body.



func set_text(compType, attachAmt, scrapAmt, currentMetal, maxMetal):
	var l1 = $ColorRect/line1
	var l2 = $ColorRect/line2
	var l3 = $ColorRect/line3
	l1.clear()
	l2.clear()
	l3.clear()
	
	l1.push_color(Color(255, 255, 255)) # white
	l1.add_text("Attaching ")
	l1.push_color(Color(255,155,0))
	l1.add_text(compType)
	l1.push_color(Color(255,255,255))
	l1.add_text(" will cost ")
	l1.push_color(Color(255,0,0))
	l1.add_text(str(attachAmt))
	l1.push_color(" metal")
	
	l2.push_color(Color(255, 255, 255))
	l2.add_text("Scrap for ")
	l2.push_color(Color(0, 255, 0))
	l2.add_text(str(scrapAmt))
	l2.push_color(Color(255, 255, 255))
	l2.add_text(" metal")
	
	l3.push_color(Color(255, 255, 255))
	l3.add_text("You have ")
	l3.push_color(Color(0, 0, 255))
	l3.add_text(str(currentMetal))
	l3.add_text("/")
	l3.add_text(str(maxMetal))
	l3.push_color(Color(255, 255, 255))
	l3.add_text(" metal ")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
