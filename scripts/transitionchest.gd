extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label2.text = str(Global.treasurescore) + " G"
	
	Global.score = Global.score + Global.treasurescore 
	Global.treasurescore = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	#get_tree().change_scene_to_file("res://scenes/level1.tscn")
	get_tree().change_scene_to_file("res://scenes/level"+ str(Global.currentlevel)+ ".tscn")
