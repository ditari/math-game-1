extends Control

var emptydoorscene: PackedScene = load("res://scenes/emptydoor.tscn")

var door1
var door2
var door3

func _ready():
	update_sprite_position()
	self.resized.connect(update_sprite_position)  # Godot 4 syntax
	
func update_sprite_position():
	var screen_size = get_viewport_rect().size
	
	#xgaps kalau tiga
	var xgaps = (screen_size.x - 384)/4
	#xgaps kalau dua
	#var xgaps = (screen_size.x - 256)/3
	#xgaps kalau satu
	#var xgaps = (screen_size.x - 128)/2
	
	var ygaps = (screen_size.y-512)/7
	#garis atas score dan gaps jadi 2
	#3 gaps antara door-enemy, enemy-pc, pc-garis bawah
	#garis bawah hp dan key jadi 2
	
	
	door1 = emptydoorscene.instantiate()
	door1.position = Vector2(xgaps,2*ygaps)
	$array.add_child(door1)
	door1.connect("button_pressed", _on_button_pressed)
	
	door2 = emptydoorscene.instantiate()
	door2.position = Vector2((2*xgaps)+128,2*ygaps)
	$array.add_child(door2)
	door2.connect("button_pressed", _on_button_pressed)

	door3 = emptydoorscene.instantiate()
	door3.position = Vector2((3*xgaps)+256,2*ygaps)
	$array.add_child(door3)
	door3.connect("button_pressed", _on_button_pressed)


	$enemy.position.y = (3*ygaps) + 256
	$enemy.position.x = (screen_size.x - 128)/2

	$pc.position.y = (4*ygaps)+384
	$pc.position.x = (screen_size.x - 128)/2

# Called when the node enters the scene tree for the first time.

func _on_button_pressed():
	print("here")
