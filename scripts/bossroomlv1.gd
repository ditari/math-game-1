extends Control

#var bgwallscene: PackedScene = load("res://scenes/bgwall.tscn")
#var bgwall

var bossscene: PackedScene = load("res://scenes/bosslv1.tscn")
var boss
# Called when the node enters the scene tree for the first time.
func _ready():
	#bgwall = bgwallscene.instantiate()
	#bgwall.position = Vector2(0,128)
	#$array.add_child(bgwall)
	
	var screen_size = get_viewport_rect().size
	var xgaps = (screen_size.x - 192)/2
	
	boss = bossscene.instantiate()
	boss.position = Vector2(xgaps,600)
	boss.scale = Vector2(1.5,1.5)
	
	$array.add_child(boss)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
