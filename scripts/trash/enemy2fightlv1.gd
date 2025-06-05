extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#jika win
func _on_touch_screen_button_pressed():
	var n = Global.currentenemy
	Global.isenemyexist[n] = 0
	
	#dapat gold atau dapat redkey
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 



#jika lose
func _on_touch_screen_button_2_pressed():
	#minus hp
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 
