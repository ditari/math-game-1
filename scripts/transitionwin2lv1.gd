extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_1_pressed():
	print ("go to level 2")

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/transitionwin3lv1.tscn") 


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn") 



