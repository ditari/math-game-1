extends Control

var emptydoorscene: PackedScene = load("res://scenes/emptydoor.tscn")
var stripedoorscene: PackedScene = load("res://scenes/stripedoor.tscn")
var reddoorscene: PackedScene = load("res://scenes/reddoor.tscn")

var bgwallscene: PackedScene = load("res://scenes/bgwall.tscn")

var enemy1scene: PackedScene = load("res://scenes/enemy1.tscn")
var enemy2scene: PackedScene = load("res://scenes/enemy2.tscn")
#var enemy3: PackedScene = load("res://scenes/enemy3.tscn") untuk level 1 hanya 2 enemy

var treasurescene: PackedScene = load("res://scenes/treasure.tscn")
var pcdiamondscene: PackedScene = load("res://scenes/pcdiamond.tscn")
var pcdiamondgrayscene: PackedScene = load("res://scenes/pcdiamondgray.tscn")

var bgwall

var door
var enemy
var content

var screen_size_x
var screen_size_y
var xgaps
var ygaps

var numberofdoors
var rng = RandomNumberGenerator.new()	

func _ready():
	sprite_position()
	#self.resized.connect(update_sprite_position)  # Godot 4 syntax
	sprite_position_2()
	
	$playerprogressbar.value = Global.playerhp
	$scorelabel.text = "SCORE: " +str (Global.score)
	
	if Global.items[1] > 0:
		$key1.get_node("AnimatedSprite2D").play("on")	
	if Global.items[2] > 0:
		$key2.get_node("AnimatedSprite2D").play("on")
	
	$key1label.text = str(Global.items[1])
	$key2label.text = str(Global.items[2])	
		
	#calculator	
	if Global.calculator == 0:
		$calculator.visible = false
		$calculatorlabel.visible = false
	else:
		$calculatorlabel.text = str (Global.calculator)
		
	audio_controller.play_ambient_industrial()
	
		

func sprite_position():
	var screen_size = get_viewport_rect().size
	screen_size_x = screen_size.x
	screen_size_y = screen_size.y

	ygaps = screen_size_y/10
	#print(ygaps)
		
	#buat bg
	bgwall = bgwallscene.instantiate()
	bgwall.position = Vector2(0,ygaps)
	$array.add_child(bgwall)
		
	numberofdoors = Global.numberofdoors
	
	if numberofdoors == 3:
		xgaps = (screen_size_x - 384)/4	
	elif numberofdoors == 2:
		xgaps = (screen_size_x - 256)/3
	else : 
		xgaps = (screen_size_x - 128)/2
		
	#buat pintu
	createdoor(1, Global.door1type)
	if numberofdoors >=2 :
		createdoor(2, Global.door2type)
	if numberofdoors == 3:
		createdoor(3, Global.door3type)	
	
	generateenemy()
	generatecontent()
	
func sprite_position_2():
	#$scorelabel.position.x = (screen_size_x - 150)/2 
	$scorelabel.position.y = 0.3 * ygaps	
	
	$hplabel.position.x = 32
	$hplabel.position.y = 8*ygaps + 60
	
	$playerprogressbar.position.x = 192
	$playerprogressbar.position.y = 8*ygaps + 72
	
	$itemlabel.position.x = 32
	$itemlabel.position.y = 9*ygaps + 16
	
	$key1.position.x = 192
	$key1.position.y = 9*ygaps

	$key1label.position.x =256
	$key1label.position.y =9*ygaps
	
	$key2.position.x = 368 #384
	$key2.position.y = 9*ygaps	
	
	$key2label.position.x =432 #448
	$key2label.position.y =9*ygaps
	
	$calculator.position.x = 544
	$calculator.position.y = 9*ygaps
	
	$calculatorlabel.position.x = 608
	$calculatorlabel.position.y = 9*ygaps
		
func createdoor(doorposition, type):
	#var type = generatedoortype()
	
	if type == 1 :
		door = emptydoorscene.instantiate()
		door.connect("button_pressed", self._emptydoor_on_button_pressed)
	elif type == 2:
		door = stripedoorscene.instantiate()
		door.connect("button_pressed", self._stripedoor_on_button_pressed)
	else :
		door = reddoorscene.instantiate()
		door.connect("button_pressed", self._reddoor_on_button_pressed)
	
	var n = 0
	if  doorposition == 1 :
		door.position = Vector2(xgaps,ygaps+128)#Vector2(xgaps, ygaps) #
		n = 1
	elif doorposition == 2 :
		door.position = Vector2((2*xgaps)+128,ygaps+128)
		n = 2
	else :
		door.position = Vector2((3*xgaps)+256,ygaps+128)
		n = 3 

	door.number = n		
	$array.add_child(door)
	
	if Global.currentdooropened == n :
		door.get_node("AnimatedSprite2D").play("unlocked")
		audio_controller.play_doorbell()	
		await get_tree().create_timer(0.5).timeout
		Global.currentdooropened = 0
	#if dooropen is true play animation open
	elif Global.arraydooropen [n] == 1 :
		door.get_node("AnimatedSprite2D").play("open")
	
func _emptydoor_on_button_pressed(sender, number):
	#jika tidak ada enemy
	if Global.isenemyexist[number]==0:	
		sender.get_node("AnimatedSprite2D").play("opening")
		audio_controller.play_sliding_door()
		await get_tree().create_timer(0.5).timeout
		loadnextlevel(1)
	else :
		Global.currentenemy = number
		#audio_controller.stop_ambient_industrial()
		audio_controller.play_buzzer()
		get_tree().change_scene_to_file("res://scenes/transitionenemyblockedlv1.tscn")	

func _stripedoor_on_button_pressed(sender,number):
	#jika tidak ada enemy
	if Global.isenemyexist[number]==0:	
		#kalau door open
		if Global.arraydooropen [number] == 1 :
			sender.get_node("AnimatedSprite2D").play("opening")
			audio_controller.play_sliding_door()
			await get_tree().create_timer(0.5).timeout		
			loadnextlevel(2)
		#doorclose	
		else :
			Global.currentdoor = number
			audio_controller.play_door_open()
			await get_tree().create_timer(0.3).timeout
			
			#audio_controller.stop_ambient_industrial()
			get_tree().change_scene_to_file("res://scenes/doorfightlv1.tscn") 
	else :
		Global.currentenemy = number
		#audio_controller.stop_ambient_industrial()
		audio_controller.play_buzzer()
		get_tree().change_scene_to_file("res://scenes/transitionenemyblockedlv1.tscn")
	
func _reddoor_on_button_pressed(sender, number):
	#jika tidak ada enemy
	if Global.isenemyexist[number]==0:	
		#kalau door open ke boss
		if Global.arraydooropen [number] == 1 :
			sender.get_node("AnimatedSprite2D").play("opening")
			audio_controller.play_sliding_door()
			await get_tree().create_timer(0.5).timeout
			
			#audio_controller.stop_ambient_industrial()				
			get_tree().change_scene_to_file("res://scenes/bossroomlv1.tscn")
		#kalau doorclose	
		else :
			Global.currentdoor = number
			audio_controller.play_door_open()
			await get_tree().create_timer(0.3).timeout
			
			#audio_controller.stop_ambient_industrial()
			get_tree().change_scene_to_file("res://scenes/transitionbossdoorlv1.tscn") 
	else :
		Global.currentenemy = number
		#audio_controller.stop_ambient_industrial()
		audio_controller.play_buzzer()
		get_tree().change_scene_to_file("res://scenes/transitionenemyblockedlv1.tscn")	
	
	
func generateenemy():
	var e = 0 
	
	#enemy di door paling kiri
	e = Global.isenemyexist[1]
	if e != 0 :
		enemytype(xgaps,4*ygaps + 32,1,e)
	
	#enemy di door tengah
	e = Global.isenemyexist[2]
	if e != 0 :
		enemytype((2*xgaps)+128,4*ygaps+ 32,2,e)

	#enemy di door kanan
	e = Global.isenemyexist[3]
	if e != 0 :
		enemytype((3*xgaps)+256,4*ygaps+ 32,3,e)
			
func enemytype(xpos,ypos,number,type) :
	if type == 1:
		enemy = enemy1scene.instantiate()
	else:
		enemy = enemy2scene.instantiate()
	
	enemy.connect("button_pressed", _enemy_on_button_pressed)
	
	enemy.position = Vector2(xpos,ypos)
	enemy.number = number
	enemy.type = type

	#animation
	enemy.get_node("AnimatedSprite2D").play("idle")	

	$array.add_child(enemy)	
	

			
func _enemy_on_button_pressed(number,type):
	Global.currentenemy = number
	Global.currentenemytype = type
	
	audio_controller.play_reload()
	await get_tree().create_timer(0.5).timeout
	
	#audio_controller.stop_ambient_industrial()
	get_tree().change_scene_to_file("res://scenes/enemyfightlv1.tscn") 
		
func generatecontent():
	var gaps = (screen_size_x - 128)/2
	
	if Global.whatexist == 1:
		content = treasurescene.instantiate()		
		content.connect("button", _treasure_on_button_pressed)	
		content.position = Vector2(gaps,7*ygaps)
	elif Global.whatexist == 2:
		content = pcdiamondscene.instantiate()
		content.connect("button", _scale_on_button_pressed)	
		content.position = Vector2(gaps,6*ygaps) #(screen_size_x - 128)/2,758
	elif Global.whatexist == 3:
		content = pcdiamondgrayscene.instantiate()
		content.position = Vector2(gaps,6*ygaps)
					
	else:
		return

	$array.add_child(content)	

func _treasure_on_button_pressed():
	Global.whatexist = 0
	audio_controller.play_glass()
	#await get_tree().create_timer(0.5).timeout
	#audio_controller.stop_ambient_industrial()
	get_tree().change_scene_to_file("res://scenes/transitionchest.tscn") 


func _scale_on_button_pressed():
	Global.whatexist = 3
	#jadiabu2
	audio_controller.play_beep()
	await get_tree().create_timer(0.4).timeout
	
	#audio_controller.stop_ambient_industrial()
	get_tree().change_scene_to_file("res://scenes/puzzlelv1.tscn") 

#---------------generate buat level berikutnya-----------
func generatedoortype():
	var type
	#var rng = RandomNumberGenerator.new()	
	var r
	#Global.enemydefeated > 1 and
	if Global.numberofdoors > 1 and Global.reddoorexist == 0 and Global.enemydefeated > 3 :
		r = rng.randi_range(0, 5)
		if r <= 2 :
			type = 1
		elif r <= 4:
			type = 2
		else :
			#generate type = red door
			type = 3
			Global.reddoorexist = 1
			var key1 = rng.randi_range(1,3)
			var key2 = rng.randi_range(1,3)
			Global.reddoorkey = [0,key1,key2,0,0,0,0,0]
			
	else:
		r = rng.randi_range(0, 2)
		if r <= 1 :
			type = 1
		else :
			type = 2

	#print(type)	
		
	return type
		
func generatenumberofdoors():
	#var rng = RandomNumberGenerator.new()	
	
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



func generateenemyarray(numberofdoors):
	#var rng = RandomNumberGenerator.new()	
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
	

func generatewhatnext(doortype):
	if doortype == 1 :
		var n = rng.randi_range(1,4)
		#ada 1/4 kemungkinan ada treasure
		if n == 1 :
			Global.whatexist = 1
			#generate score treasure
			Global.treasurescore = randi_range(10,50)
		else :	
			Global.whatexist = 0

	elif doortype == 2:
		var n = rng.randi_range(1,6)
		#3/6 kemungkinan empty 2/6 kemungkinan treasure 1/6 kemungkinan scale
		if n < 3:
			Global.whatexist = 1
			Global.treasurescore = randi_range(50,100)
		elif n == 3 :
			Global.whatexist = 2	
		else :	
			Global.whatexist = 0
	
func loadnextlevel(doortype):	
	Global.arraydooropen = [0,0,0,0]
	Global.currentdoor = 0
	
	Global.reddoorexist = 0
	

	var d = generatenumberofdoors()
		
	Global.door1type = generatedoortype()
	Global.door2type = generatedoortype()
	Global.door3type = generatedoortype()
		
	generateenemyarray(d)

	#utk generate apakah empty, treasure, atau neraca
	generatewhatnext(doortype)	

	get_tree().change_scene_to_file("res://scenes/level1.tscn") 
	#get_tree().change_scene_to_file("res://scenes/level"+ str(Global.currentlevel)+ ".tscn")
