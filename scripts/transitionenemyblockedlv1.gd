extends Control

var enemy1scene: PackedScene = load("res://scenes/enemy1.tscn")
var enemy2scene: PackedScene = load("res://scenes/enemy2.tscn")
var enemy
# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport_rect().size
	$Messagebox.position.y = screen_size.y/2
	#print(Global.currentenemy)
	var enemytype = Global.isenemyexist[Global.currentenemy]
	
	if enemytype == 1:
		enemy = enemy1scene.instantiate()
	else :
		enemy = enemy2scene.instantiate()
	
	enemy.position = Vector2(264,(screen_size.y/2)-112)
	enemy.scale = Vector2(1.5,1.5)

	add_child(enemy)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Global.currentenemy = 0
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
