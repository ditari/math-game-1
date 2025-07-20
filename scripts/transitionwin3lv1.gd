extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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

	get_tree().change_scene_to_file("res://scenes/level1.tscn") 


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/transitionwin2lv1.tscn") 
