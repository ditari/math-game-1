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

# Called when the node enters the scene tree for the first time.
func _ready():
	#calculator
	if Global.calculator == 0:
		$calculator.visible = false
		$calculator/calculatorlabel.visible = false
	else :
		$calculator/calculatorlabel.text = str(Global.calculator)
	
	$calculator.button_pressed.connect(_on_calculator_button_pressed)	

	generatequestion()
	
	$enemyprogressbar.value = enemyhp
	$playerprogressbar.value = Global.playerhp
	
	$timer.wait_time = 15
	$timer.start() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#calculator
	if Global.calculator == 0:
		$calculator.visible = false
		$calculator/calculatorlabel.visible = false
	else :
		$calculator/calculatorlabel.text = str(Global.calculator)

	if $timer.time_left > 0:
		$timerprogressbar.value = $timer.time_left
	
	$answerlabel.text = inputanswer
	
	$enemyprogressbar.value = enemyhp
	$playerprogressbar.value = Global.playerhp

	if Global.playerhp > 0 :
		if enemyhp == 0:
			win()
	else :
		gameover()


func generatequestion():
	var type = randi_range(1,2)
	if type == 1:
		generatequestionplus()
	#elif type == 2 :
	else:
		generatequestionminus()	
		
func generatequestionplus():
	a = rng.randi_range(0, 5)
	b = rng.randi_range(0, 10)
	answer = a+b
	
	var type = randi_range(1,2)
	if type == 1:
		question = str(a) + " + " + str(b) + " = ?"
	else:
		question = str(b) + " + " + str(a) + " = ?"
			
	$questionlabel.text = question
	
func generatequestionminus():
	answer = rng.randi_range(0, 5)
	b = rng.randi_range(0, 5)
	a = answer+b
	question = str(a) + " - " + str(b) + " = ?"
	
	$questionlabel.text = question
	
func _on_calculator_button_pressed():
	Global.calculator = Global.calculator - 1
	inputanswer = str (answer)

	enemyhp = enemyhp -1
	#play animation
	$boss.get_node("AnimatedSprite2D").play("hurt")
		
	await get_tree().create_timer(0.5).timeout	
	$boss.get_node("AnimatedSprite2D").play("idle")

	inputanswer = ""
	
	if enemyhp > 0:
		generatequestion()
		$timer.start()		

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
		$boss.get_node("AnimatedSprite2D").play("hurt")
	else :
		Global.playerhp = Global.playerhp - minusplayer
		#chance = chance - 1
		#play animation
		$boss.get_node("AnimatedSprite2D").play("fire")
		#flash screen here
		$AnimatedSprite2D.play("flash")
		
	await get_tree().create_timer(0.5).timeout	
	$boss.get_node("AnimatedSprite2D").play("idle")

	inputanswer = ""
	
	if enemyhp > 0:
		generatequestion()
		$timer.start()	

func _on_timer_timeout():
	Global.playerhp = Global.playerhp - minusplayer
		#chance = chance - 1
	#play animation
	$boss.get_node("AnimatedSprite2D").play("fire")
		#flash screen here
	$AnimatedSprite2D.play("flash")
	
	await get_tree().create_timer(0.5).timeout	
	$boss.get_node("AnimatedSprite2D").play("idle")

	inputanswer = ""

	if enemyhp > 0:
		generatequestion()
		$timer.start()


func win():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/transitionwin1lv1.tscn") 


func gameover():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/gameover.tscn") 
