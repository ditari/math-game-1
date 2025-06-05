extends Control

var emptydoorscene: PackedScene = load("res://scenes/emptydoor.tscn")
var stripedoorscene: PackedScene = load("res://scenes/stripedoor.tscn")
var reddoorscene: PackedScene = load("res://scenes/reddoor.tscn")

var enemy1: PackedScene = load("res://scenes/enemy1.tscn")
var enemy2: PackedScene = load("res://scenes/enemy2.tscn")
#var enemy3: PackedScene = load("res://scenes/enemy3.tscn") untuk level 1 hanya 2 enemy

var door
var enemy
var xgaps
var ygaps

var numberofdoors

func _ready():
	update_sprite_position()
	self.resized.connect(update_sprite_position)  # Godot 4 syntax
	
	$playerprogressbar.value = Global.playerhp



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
	
	generateenemy()

	#treasure ga pakai pc
	$pc.position.y = 7*ygaps
	$pc.position.x = (screen_size.x - 128)/2

	#treasure
	#$pc2.position.y = 6*ygaps
	#$pc2.position.x = (screen_size.x - 128)/2

func createdoor(doorposition, type):
	#var type = generatedoortype()
	
	if type == 1 :
		door = emptydoorscene.instantiate()
		door.connect("button_pressed", self._emptydoor_on_button_pressed)
	elif type == 2:
		door = stripedoorscene.instantiate()
		door.connect("button_pressed", _stripedoor_on_button_pressed)
	else :
		door = reddoorscene.instantiate()
		door.connect("button_pressed", _reddoor_on_button_pressed)
	
	var n = 0
	if  doorposition == 1 :
		door.position = Vector2(xgaps,2*ygaps-64)#Vector2(xgaps, ygaps) #
		n = 1
	elif doorposition == 2 :
		door.position = Vector2((2*xgaps)+128,2*ygaps-64)
		n = 2
	else :
		door.position = Vector2((3*xgaps)+256,2*ygaps-64)
		n = 3 

	door.number = n		
	$array.add_child(door)
	#if dooropen is true play animation open
	if Global.arraydooropen [n] == 1 :
		door.get_node("AnimatedSprite2D").play("open")
	
func _emptydoor_on_button_pressed(sender, number):
	#jika tidak ada enemy
	if Global.isenemyexist[number]==0:	
		sender.get_node("AnimatedSprite2D").play("open")
		await get_tree().create_timer(0.7).timeout
		loadnextlevel(1)
	else :
		print("enemy block the door")	

func _stripedoor_on_button_pressed(number):
	#jika tidak ada enemy
	if Global.isenemyexist[number]==0:	
		#kalau door open
		if Global.arraydooropen [number] == 1 :
			loadnextlevel(2)
		#doorclose	
		else :
			Global.currentdoor = number
			get_tree().change_scene_to_file("res://scenes/doorfight2choice.tscn") 
	else :
		print("enemy block the door")	
	
func _reddoor_on_button_pressed(number):
	#jika tidak ada enemy
	if Global.isenemyexist[number]==0:	
		#kalau door open
		if Global.arraydooropen [number] == 1 :
			loadnextlevel(3)
		#doorclose	
		else :
			Global.currentdoor = number
			get_tree().change_scene_to_file("res://scenes/doorunlocklv1.tscn") 
	else :
		print("enemy block the door")	
	
	
	#	if Global.hasredkey == 1:	
	#	loadnextlevel(3)
	#else message you dont have key	

func generateenemy():
	var e = 0 
	
	#enemy di door paling kiri
	e = Global.isenemyexist[1]
	if e != 0 :
		enemytype(xgaps,(3*ygaps) + 128,1,e)
	
	#enemy di door tengah
	e = Global.isenemyexist[2]
	if e != 0 :
		enemytype((2*xgaps)+128,(3*ygaps) + 128,2,e)

	#enemy di door kanan
	e = Global.isenemyexist[3]
	if e != 0 :
		enemytype((3*xgaps)+256,(3*ygaps) + 128,3,e)
			
func enemytype(xpos,ypos,number,type) :
	if type == 1:
		enemy = enemy1.instantiate()
	else:
		enemy = enemy2.instantiate()
	
	enemy.connect("button_pressed", _enemy_on_button_pressed)
	
	enemy.position = Vector2(xpos,ypos)
	enemy.number = number
	enemy.type = type
	$array.add_child(enemy)	
			
func _enemy_on_button_pressed(number,type):
	Global.currentenemy = number
	Global.currentenemytype = type
	#if type == 1:
	get_tree().change_scene_to_file("res://scenes/enemyfight.tscn") 
	#else:
	#	get_tree().change_scene_to_file("res://scenes/enemy2fightlv1.tscn") 
	
#---------------generate buat level berikutnya-----------
func generatedoortype():
	var type
	var rng = RandomNumberGenerator.new()	
	var r
	#jika belum mengalahkan 3 enemy tidak akan digenerate red door
	if Global.enemydefeated < 3 :
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
		return 3
	elif r < 5 :
		Global.numberofdoors = 2
		return 2
	else:
		Global.numberofdoors = 1
		return 1

#func generatenumberofenemy():
#	var rng = RandomNumberGenerator.new()	
	
#	var r = rng.randi_range(0, 6)
#	if r == 0 :
#		return 0
#	elif r < 4 :
#		return 1
#	elif r < 6 :
#		return 2
#	else :
#		return 3	

func generateenemyarray(numberofdoors):
	var rng = RandomNumberGenerator.new()	
	#hanya ada 2 tipe enemy jadi randi_range(1,2)
	var enemy1type = rng.randi_range(1, 2)
	var enemy2type = rng.randi_range(1, 2)
	var enemy3type = rng.randi_range(1, 2)

	#jumlah enemy	
	#var n = generatenumberofenemy()
	#if n > numberofdoors :
	#	n = numberofdoors 
	# masalahnya kalau ga kayak gini bisa enemy ada 2 pintu ada 1
	var n = rng.randi_range(0,numberofdoors)
	#print (n)

	
	if numberofdoors == 1:
		if n == 0:
			Global.isenemyexist = [0,0,0,0]
		elif n == 1:
			Global.isenemyexist = [0,enemy1type,0,0]		
	elif numberofdoors == 2:
		if n == 0:
			Global.isenemyexist = [0,0,0,0]
		elif n == 1:#variasi
			var v = rng.randi_range(0,1)
			if v ==0:
				Global.isenemyexist = [0,enemy1type,0,0]
			else :		
				Global.isenemyexist = [0,0,enemy1type,0]
		elif n == 2	:
			Global.isenemyexist = [0,enemy1type,enemy2type,0]			
	else : 	
		if n == 0:
			Global.isenemyexist = [0,0,0,0]
		elif n == 1:
			Global.isenemyexist = [0,0,enemy1type,0]	
		elif n == 2	:
			Global.isenemyexist = [0,enemy1type,0,enemy2type]	
		else :
			Global.isenemyexist = [0,enemy1type,enemy2type,enemy3type]	
	
		
func loadnextlevel(doortype):	
	var d = generatenumberofdoors()
	
	Global.door1type = generatedoortype()
	Global.door2type = generatedoortype()
	Global.door3type = generatedoortype()

	Global.arraydooropen = [0,0,0,0]
	Global.currentdoor = 0
	
	#utk generate apakah empty, treasure, atau neraca
	Global.previousdoortype = doortype
	
	generateenemyarray(d)
	
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 

