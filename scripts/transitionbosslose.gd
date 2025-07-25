extends Control

var boss1scene: PackedScene = load("res://scenes/bosslv1.tscn")
var boss
# Called when the node enters the scene tree for the first time.
func _ready():
	boss = boss1scene.instantiate()		
	boss.position = Vector2(300,450)
	add_child(boss)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gameover.tscn") 
