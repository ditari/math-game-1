extends Control

var emptydoorscene: PackedScene = load("res://scenes/emptydoor.tscn")
var stripedoorscene: PackedScene = load("res://scenes/stripedoor.tscn")
var reddoorscene: PackedScene = load("res://scenes/reddoor.tscn")

var door
var xgaps
var ygaps

var numberofdoors

func _ready():
	update_sprite_position()
	self.resized.connect(update_sprite_position)  # Godot 4 syntax
	
	
func update_sprite_position():
	var screen_size = get_viewport_rect().size
	
	numberofdoors = Global.numberofdoors
	#print (numberofdoors)
	
	ygaps = (screen_size.y-512)/7
	if numberofdoors == 3:
		xgaps = (screen_size.x - 384)/4	
	elif numberofdoors == 2:
		xgaps = (screen_size.x - 256)/3
	else : 
		xgaps = (screen_size.x - 128)/2
		
	#buat pintu
	createdoor(1, Global.door1type)
	if numberofdoors >=2 :
		createdoor(2, Global.door2type)
	if numberofdoors == 3:
		createdoor(3, Global.door3type)	
	
	$enemy.position.y = (3*ygaps) + 256
	$enemy.position.x = (screen_size.x - 128)/2

	$pc.position.y = (4*ygaps)+384
	$pc.position.x = (screen_size.x - 128)/2

func createdoor(doorposition, type):
	#var type = generatedoortype()
	
	if type == 1 :
		door = emptydoorscene.instantiate()
		door.connect("button_pressed", self._emptydoor_on_button_pressed.bind(door))
	elif type == 2:
		door = stripedoorscene.instantiate()
		door.connect("button_pressed", _stripedoor_on_button_pressed)
	else :
		door = reddoorscene.instantiate()
		door.connect("button_pressed", self._reddoor_on_button_pressed.bind(door))
	
	var n = 0
	if  doorposition == 1 :
		door.position = Vector2(xgaps,2*ygaps)
		n = 1
	elif doorposition == 2 :
		door.position = Vector2((2*xgaps)+128,2*ygaps)
		n = 2
	else :
		door.position = Vector2((3*xgaps)+256,2*ygaps)
		n = 3 

	door.number = n		
	$array.add_child(door)
	#if door1open is true play animation open
	if Global.arraydooropen [n] == 1 :
		door.get_node("AnimatedSprite2D").play("open")
	


func _emptydoor_on_button_pressed(sender):
	sender.get_node("AnimatedSprite2D").play("open")
	await get_tree().create_timer(0.7).timeout
	loadnextlevel()


func _stripedoor_on_button_pressed(number):
	#kalau door open
	if Global.arraydooropen [number] == 1 :
		loadnextlevel()
	else :
		Global.currentdoor = number
		get_tree().change_scene_to_file("res://scenes/doorfight.tscn") 
	
	
func _reddoor_on_button_pressed(sender):
	if Global.hasredkey == 1:
		sender.get_node("AnimatedSprite2D").play("open")
		await get_tree().create_timer(0.7).timeout	
		loadnextlevel()
	#else message you dont have key	


func generatedoortype():
	var type
	var rng = RandomNumberGenerator.new()	
	var r
	#jika tidak ada red key hanya akan digenerate 2 pintu 
	if Global.hasredkey == 0 :
		r = rng.randi_range(0, 2)
		if r <= 1 :
			type = 1
		else :
			type = 2
	else:
		r = rng.randi_range(0, 5)
		if r <= 2 :
			type = 1
		elif r <= 4:
			type = 2
		else :
			type = 3
	#print(type)	
		
	return type
		
func generatenumberofdoors():
	var rng = RandomNumberGenerator.new()	
	
	var r = rng.randi_range(0, 6)
	if r < 3 :
		Global.numberofdoors = 3
	elif r < 5 :
		Global.numberofdoors = 2
	else:
		Global.numberofdoors = 1
	
func loadnextlevel():	
	generatenumberofdoors()
	
	Global.door1type = generatedoortype()
	Global.door2type = generatedoortype()
	Global.door3type = generatedoortype()

	Global.arraydooropen = [0,0,0,0]
	Global.currentdoor = 0
	
	get_tree().change_scene_to_file("res://scenes/level.tscn") 

