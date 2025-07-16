extends Control
var enoughkey = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$key1label.text = str(Global.reddoorkey[1])
	$key2label.text = str(Global.reddoorkey[2])
	
	checkkey()
	if enoughkey == false :
		$unlockbg.play("off")
	else :
		$unlockbg.play("on")
		
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


func _on_unlockbutton_pressed():
	if enoughkey == true:
		var n = Global.currentdoor
		print(n)
		Global.arraydooropen[n] = 1
	
		#kurangi item sesuai jumlah lock key
		Global.items[1] = Global.items[1] - Global.reddoorkey[1]
		Global.items[2] = Global.items[2] - Global.reddoorkey[2]	
		
		#print("dooropen")
		get_tree().change_scene_to_file("res://scenes/transitionbossopen.tscn") 


func _on_cancelbutton_pressed():
	#print("go back")
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 

