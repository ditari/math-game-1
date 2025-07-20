extends Control


func _on_button_1_pressed():
	#ini play mulai dari level 1
	#item tidak direset kalau next level
	Global.items = [0,0,0,0]
	Global.calculator = 0

	#pintu pertama selalu open door no enemy
	Global.numberofdoors = 1
	Global.door1type = 1
	
	#sisanya pastikan mulai dari nol

	Global.currentlevel = 1
	Global.playerhp = 100
	Global.score = 0

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
	print("go to choose level")


func _on_button_3_pressed():
	get_tree().quit()
