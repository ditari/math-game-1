extends Control

var key1scene: PackedScene = load("res://scenes/key1.tscn")
var key2scene: PackedScene = load("res://scenes/key2.tscn")

var key

# Called when the node enters the scene tree for the first time.
func _ready():

	var n = Global.currentenemy
	Global.isenemyexist[n] = 0	
	Global.enemydefeated = Global.enemydefeated + 1

	var enemytype = Global.currentenemytype
	Global.items[enemytype] = Global.items[enemytype] + 1
	
	if enemytype == 1:
		key = key1scene.instantiate()
	else :
		key = key2scene.instantiate()
	
	key.position = Vector2(280,490)
	key.scale = Vector2(2,2)
	key.get_node("AnimatedSprite2D").play("on")	

	add_child(key)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level"+ str(Global.currentlevel)+ ".tscn")

