extends Control

func generatenumberofdoors():
	var rng = RandomNumberGenerator.new()	
	
	var r = rng.randi_range(0, 6)
	if r < 3 :
		Global.numberofdoors = 3
	elif r < 5 :
		Global.numberofdoors = 2
	else:
		Global.numberofdoors = 1

func generatedoortype():
	var type
	var rng = RandomNumberGenerator.new()	
	var r
	#jika tidak ada red key hanya akan digenerate 2 pintu 
	if Global.enemydefeated < 3 :
		r = rng.randi_range(0, 2)
		if r <= 1 :
			type = 1
		else :
			type = 2
	else:
		r = rng.randi_range(0, 5)
		if r <= 2 :
			type = 1
		elif r <= 4:
			type = 2
		else :
			type = 3
	#print(type)	
		
	return type
	
func loadnextlevel():	
	generatenumberofdoors()
	
	Global.door1type = generatedoortype()
	Global.door2type = generatedoortype()
	Global.door3type = generatedoortype()

	Global.arraydooropen = [0,0,0,0]
	Global.currentdoor = 0
	
	#yg awal ga ada enemy ya
	#previous doortype juga ga ada?
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 



func _on_touch_screen_button_pressed():
	loadnextlevel()
