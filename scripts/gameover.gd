extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport_rect().size
	$Messagebox.position.y = screen_size.y/2
	
	$Messagebox/scorelabel.text = "SCORE : " + str(Global.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	audio_controller.play_click()
	get_tree().change_scene_to_file("res://scenes/menu.tscn") 
