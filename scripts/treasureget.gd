extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.score = Global.score + Global.treasurescore 
	
	$Label.text = " You get "+ str(Global.treasurescore)
	Global.treasurescore = 0
	




func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
