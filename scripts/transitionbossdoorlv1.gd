extends Control
var enoughkey = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport_rect().size
	#var ygaps = screen_size.y/10
	
	$Messagebox.position.y = (screen_size.y/2) - 192 #ada button jadi ga pas di tengah
	
	$Messagebox/key1label.text = str(Global.reddoorkey[1])
	$Messagebox/key2label.text = str(Global.reddoorkey[2])

	var xgaps = (screen_size.x - 615)/3
	var ygaps = screen_size.y/10
	$unlockbutton.position.x = xgaps
	$unlockbutton.position.y = 5*ygaps +64
	
	$cancelbutton.position.x =  2*xgaps +307
	$cancelbutton.position.y =  5*ygaps +64
	
	checkkey()
	if enoughkey == false :
		$unlockbutton/unlockbg.play("off")
	else :
		$unlockbutton/unlockbg.play("on")
		
	#audio
	#audio_controller.play_click()
	#berisik udah ada suara knock dari sebelumnya
		
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
		Global.arraydooropen[n] = 1
		
		#untuk animasi
		Global.currentdooropened = n
	
		#kurangi item sesuai jumlah lock key
		Global.items[1] = Global.items[1] - Global.reddoorkey[1]
		Global.items[2] = Global.items[2] - Global.reddoorkey[2]	
		
		#print("dooropen")
		audio_controller.play_click()
		get_tree().change_scene_to_file("res://scenes/transitionbossopen.tscn") 


func _on_cancelbutton_pressed():
	#print("go back")
	audio_controller.play_click()
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 

