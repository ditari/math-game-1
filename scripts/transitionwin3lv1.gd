extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport_rect().size
	var xgaps = (screen_size.x - 512)/3
	#print(xgaps)
	#var ygaps = screen_size.y/10
	
	$Messagebox.position.y = (screen_size.y/2) - 180 #ada button jadi ga pas di tengah
	$Label.position.y = (screen_size.y/2) - 256
	
	$bg1.position.x = xgaps + 128
	$bg1.position.y = (screen_size.y/2) + 96
	
	$bg2.position.x = 2*xgaps + 384
	$bg2.position.y = (screen_size.y/2) + 96	
	#$bg1.position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_1_pressed():
	#kalau replay hp score balik reset item sama kalkulator tinggal
	Global.currentlevel = 1
	Global.playerhp = 100
	Global.score = 0

	#pintu pertama selalu open door no enemy
	Global.numberofdoors = 1
	Global.door1type = 1

	Global.arraydooropen = [0,0,0,0]
	Global.currentdoor = 0
	Global.reddoorexist = 0 
	
	Global.isenemyexist = [0,0,0,0]
	Global.currentenemy = 0
	Global.currentenemytype = 0
	Global.enemydefeated = 0 
	
	Global.whatexist = 0
	Global.treasurescore = 0

	audio_controller.play_click()
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 


func _on_button_2_pressed():
	audio_controller.play_click()
	get_tree().change_scene_to_file("res://scenes/transitionwin2lv1.tscn") 
