extends Control

var a =0
var b =0
var answer =0

var question = ""
var inputanswer = ""

var rng = RandomNumberGenerator.new()

var enemyhp = 3
var chance = 3 
var minusplayer = 5

var enemy1: PackedScene = load("res://scenes/enemy1.tscn")
var enemy2: PackedScene = load("res://scenes/enemy2.tscn")
var enemy



# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.currentenemytype == 1 :
		enemy = enemy1.instantiate()
	elif Global.currentenemytype == 2 :	
		enemy = enemy2.instantiate()

	enemy.position = Vector2(275,200)
	enemy.scale = Vector2(1.5,1.5)
	add_child(enemy)
	
	generatequestion(Global.currentenemytype)
	
	$enemyprogressbar.value = enemyhp
	$playerprogressbar.value = Global.playerhp
	
	$timer.wait_time = 15
	$timer.start() 
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $timer.time_left > 0 and chance > 0:
		$timerprogressbar.value = $timer.time_left
	
	$answerlabel.text = inputanswer
	$chancelabel.text = "chance = " + str(chance) + "/3"
	
	$enemyprogressbar.value = enemyhp
	$playerprogressbar.value = Global.playerhp
	
	#checkifchance==0 or enemyhp == 0
	#win or lose
	if chance == 0 :
		lose()
	elif enemyhp == 0:
		win()
	
func generatequestion(type):
	if type == 1:
		generatequestionplus()
	elif type == 2 :
		var v = randi_range(1,2)
		if v == 1 :
			generatequestionplus()
		else :
			generatequestionminus()				

func generatequestionplus():
	a = rng.randi_range(0, 10)
	b = rng.randi_range(0, 10)
	answer = a+b
	question = str(a) + " + " + str(b) + " = "
	
	$questionlabel.text = question
	
func generatequestionminus():
	answer = rng.randi_range(0, 10)
	b = rng.randi_range(0, 10)
	a = answer+b
	question = str(a) + " - " + str(b) + " = "
	
	$questionlabel.text = question

	
func _on_button_1_pressed():
	if inputanswer.length() < 3 :
		inputanswer = inputanswer + "1"

func _on_button_2_pressed():
	if inputanswer.length() < 3 :	
		inputanswer = inputanswer + "2"

func _on_button_3_pressed():
	if inputanswer.length() < 3 :	
		inputanswer = inputanswer + "3"

func _on_button_4_pressed():
	if inputanswer.length() < 3 :
		inputanswer = inputanswer + "4"

func _on_button_5_pressed():
	if inputanswer.length() < 3 :
		inputanswer = inputanswer + "5"
	
func _on_button_6_pressed():
	if inputanswer.length() < 3 :
		inputanswer = inputanswer + "6"	

func _on_button_7_pressed():
	if inputanswer.length() < 3 :
		inputanswer = inputanswer + "7"	

func _on_button_8_pressed():
	if inputanswer.length() < 3 :
		inputanswer = inputanswer + "8"	

func _on_button_9_pressed():
	if inputanswer.length() < 3 :
		inputanswer = inputanswer + "9"	
		
func _on_buttonerase_pressed():
	if inputanswer.length() > 0 :
		inputanswer = inputanswer.substr(0, inputanswer.length() - 1)

func _on_button_0_pressed():
	if inputanswer.length() < 3 :
		inputanswer = inputanswer + "0"	

func _on_buttonequal_pressed():
	var input = int(inputanswer)
	if input == answer:
		enemyhp = enemyhp -1
		#play animation
	else :
		Global.playerhp = Global.playerhp - minusplayer
		chance = chance - 1
		#play animation
		
	#clearinput
	inputanswer = ""
	
	if chance > 0 and enemyhp > 0:
		generatequestion(Global.currentenemytype)
		$timer.start()	


func _on_timer_timeout():
	if chance > 0 :
		chance = chance-1
		Global.playerhp = Global.playerhp - minusplayer
		#play animation

		generatequestion(Global.currentenemytype)
		$timer.start()
		
#jika win
func win():
	var n = Global.currentenemy
	Global.isenemyexist[n] = 0
	
	Global.enemydefeated = Global.enemydefeated + 1
	
	print("you win")
	#dapat gold atau dapat redkey
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 



#jika lose
func lose():
	print ("you lose")
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 


