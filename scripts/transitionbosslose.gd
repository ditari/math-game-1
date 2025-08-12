extends Control

#var boss1scene: PackedScene = load("res://scenes/bosslv1.tscn")
#var boss
# Called when the node enters the scene tree for the first time.
func _ready():
	#boss = boss1scene.instantiate()		
	#boss.position = Vector2(300,450)
	#add_child(boss)
	var screen_size = get_viewport_rect().size
	var ygaps = screen_size.y/2
	
	$Messagebox.position.y = ygaps
	$Label.position.y = ygaps - 240
	$Label2.position.y = ygaps + 160
	$Node2D.position.y = ygaps - 156
	#$array.position.y = ygaps
	#audio_controller.play_buzzer()
	#await get_tree().create_timer(0.5).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	audio_controller.play_you_lost()
	get_tree().change_scene_to_file("res://scenes/gameover.tscn") 
