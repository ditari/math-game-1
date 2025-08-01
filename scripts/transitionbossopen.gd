extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport_rect().size
	var ygaps = screen_size.y/2
	
	$Messagebox.position.y = ygaps 
	$Label.position.y = ygaps - 240
	$Label2.position.y = ygaps + 144
	$Bossdooropen.position.y = ygaps
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level"+ str(Global.currentlevel)+ ".tscn")
