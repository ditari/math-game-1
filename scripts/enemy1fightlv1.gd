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


# Called when the node enters the scene tree for the first time.
func _ready():
	$enemyprogressbar.value = enemyhp
	$playerprogressbar.value = Global.playerhp
	
	$timer.wait_time = 10
	$timer.start() 
	
	generatequestion()


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
	

func generatequestion():
	a = rng.randi_range(0, 10)
	b = rng.randi_range(0, 10)
	answer = a+b
	question = str(a) + " + " + str(b) + " = "
	
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
		generatequestion()
		$timer.start()	


func _on_timer_timeout():
	if chance > 0 :
		chance = chance-1
		Global.playerhp = Global.playerhp - minusplayer
		#play animation

		generatequestion()
		$timer.start()
		
#jika win
func win():
	var n = Global.currentenemy
	Global.isenemyexist[n] = 0
	
	print("you win")
	#dapat gold atau dapat redkey
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 



#jika lose
func lose():
	print ("you lose")
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 


