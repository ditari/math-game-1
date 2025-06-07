extends Control
var enoughkey = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("need key1 :" + str(Global.reddoorkey[1]))
	print ("need key2 :" + str(Global.reddoorkey[2]))
	print("have item1 :" + str(Global.items[1]))
	print ("have item2 :" + str(Global.items[2]))
	
	checkkey()
	if enoughkey == false :
		$unlock.hide()
		#taruh di center
		$goback.position = Vector2(200,500)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func checkkey():
	var key1 = Global.reddoorkey[1]
	var key2 = Global.reddoorkey[2]

	var item1 = Global.items[1]
	var item2 = Global.items[2]

	if item1 >= key1 and item2 >= key2:
		enoughkey = true
	
func _on_unlock_pressed():
	var n = Global.currentdoor
	Global.arraydooropen[n] = 1
	
	#kurangi item sesuai jumlah lock key
	Global.items[1] = Global.items[1] - Global.reddoorkey[1]
	Global.items[2] = Global.items[2] - Global.reddoorkey[2]	
	print("use items to unlock door")
	
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 


func _on_goback_pressed():
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 
