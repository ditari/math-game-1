extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport_rect().size
	var ygaps = screen_size.y/10
	var xgaps = (screen_size.x - 256)/2
	
	$Messagebox.position.y = ygaps + 154
	$Label.position.y = ygaps
	
	$bg1.position.x = xgaps + 128
	$bg1.position.y = 5*ygaps - 64

	$bg2.position.x = xgaps + 128	
	$bg2.position.y = 6*ygaps 
	
	$bg3.position.x = xgaps + 128
	$bg3.position.y = 8*ygaps - 64	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_1_pressed():
	print ("go to level 2")

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/transitionwin3lv1.tscn") 


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn") 



