extends Control

var a =0
var b =0
var answer =0

var question = ""
var inputanswer = ""

var rng = RandomNumberGenerator.new()

var enemyhp = 5
#var chance = 3 
var minusplayer = 10
var waittime = 10

#var enemy1: PackedScene = load("res://scenes/enemy1.tscn")
#var enemy2: PackedScene = load("res://scenes/enemy2.tscn")
var enemy

#var enemytype = Global.currentenemytype


# Called when the node enters the scene tree for the first time.
func _ready():
	generatequestion()
	
	$enemyprogressbar.value = enemyhp
	$playerprogressbar.value = Global.playerhp
	
	$timer.wait_time = waittime
	$timer.start() 
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $timer.time_left > 0 and Global.playerhp > 0:
		$timerprogressbar.value = $timer.time_left
	
	$answerlabel.text = inputanswer
	#$chancelabel.text = "chance = " + str(chance) + "/3"
	
	$enemyprogressbar.value = enemyhp
	$playerprogressbar.value = Global.playerhp
	
	#checkifchance==0 or enemyhp == 0
	#win or lose
	if Global.playerhp == 0 :
		lose()
	elif enemyhp == 0:
		win()
	
func generatequestion():
	var v = randi_range(1,2)
	if v == 1 :
		generatequestionplus()
	else :
		generatequestionminus()				

func generatequestionplus():
	a = rng.randi_range(0, 5)
	b = rng.randi_range(0, 5)
	answer = a+b
	question = str(a) + " + " + str(b) + " = "
	
	$questionlabel.text = question
	
func generatequestionminus():
	answer = rng.randi_range(0, 5)
	b = rng.randi_range(0, 5)
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
		#play animation
		
	#clearinput
	inputanswer = ""
	
	if Global.playerhp > 0 and enemyhp > 0:
		generatequestion()
		$timer.start()	


func _on_timer_timeout():
	if Global.playerhp > 0 :
		Global.playerhp = Global.playerhp - minusplayer
		#play animation

		generatequestion()
		$timer.start()
		

		
#jika win
func win():
	#var n = Global.currentenemy
	#Global.isenemyexist[n] = 0
	
	#Global.enemydefeated = Global.enemydefeated + 1
	
	print("you win")
	#dapat gold
	#var reward = rng.randi_range(1,50)
	#Global.score = Global.score+reward
	#print ("you got reward " + str (reward))
	
	#Global.items[enemytype] = Global.items[enemytype] + 1
	#print ("you got key item " + str (enemytype))
		
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 



#jika lose
func lose():
	print ("you lose")
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 


