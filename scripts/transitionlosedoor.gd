extends Control


# Called when the node enters the scene tree for the first time.
func _ready():

	var screen_size = get_viewport_rect().size
	var ygaps = screen_size.y/2
	
	$Messagebox.position.y = ygaps
	$Label.position.y = ygaps - 240
	$Label2.position.y = ygaps + 160
	$Node2D.position.y = ygaps - 128
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if Global.playerhp == 0:
		get_tree().change_scene_to_file("res://scenes/gameover.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/level"+ str(Global.currentlevel)+ ".tscn")
