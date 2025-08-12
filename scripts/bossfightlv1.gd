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

var xgaps
var ygaps

# Called when the node enters the scene tree for the first time.
func _ready():
	update_sprite()
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
	
	audio_controller.play_ambient_industrial()

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

func update_sprite():
	var screen_size = get_viewport_rect().size
	ygaps = screen_size.y/10
	#xgaps = (screen_size.x - 192)/2

	$calculator.position.x = screen_size.x - 128
	$calculator.position.y = ygaps - 112
	
	$timerprogressbar.position.x = (screen_size.x - 300)/2
	$timerprogressbar.position.y = ygaps - 112
	
	$enemyprogressbar.position.x = (screen_size.x - 300)/2
	$enemyprogressbar.position.y = ygaps - 64
	
	$boss.position.x = (screen_size.x - 167)/2
	$boss.position.y = ygaps - 16
	
	$questionlabel.position.y = 3*ygaps +48
	$answerlabel.position.y = 4*ygaps+12
	
	$VBoxContainer.position.y = 5*ygaps + 16
	
	$hplabel.position.x = 32
	$hplabel.position.y = 9*ygaps + 48
	
	$playerprogressbar.position.x = 148
	$playerprogressbar.position.y = 9*ygaps + 64
	
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
	audio_controller.play_ding()
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
		audio_controller.play_click()
		if inputanswer == "0" :
			inputanswer = "1"
		else:	
			inputanswer = inputanswer + "1"

func _on_button_2_pressed():
	if inputanswer.length() < 3 :	
		audio_controller.play_click()
		if inputanswer == "0" :
			inputanswer = "2"
		else:	
			inputanswer = inputanswer + "2"

func _on_button_3_pressed():
	if inputanswer.length() < 3 :
		audio_controller.play_click()
		if inputanswer == "0" :
			inputanswer = "3"
		else:				
			inputanswer = inputanswer + "3"

func _on_button_4_pressed():
	if inputanswer.length() < 3 :
		audio_controller.play_click()
		if inputanswer == "0" :
			inputanswer = "4"
		else:	
			inputanswer = inputanswer + "4"

func _on_button_5_pressed():
	if inputanswer.length() < 3 :
		audio_controller.play_click()
		if inputanswer == "0" :
			inputanswer = "5"
		else:	
			inputanswer = inputanswer + "5"
	
func _on_button_6_pressed():
	if inputanswer.length() < 3 :
		audio_controller.play_click()
		if inputanswer == "0" :
			inputanswer = "6"
		else:			
			inputanswer = inputanswer + "6"	

func _on_button_7_pressed():
	if inputanswer.length() < 3:
		audio_controller.play_click()
		if inputanswer == "0" :
			inputanswer = "7"
		else:			
			inputanswer = inputanswer + "7"	

func _on_button_8_pressed():
	if inputanswer.length() < 3 :
		audio_controller.play_click()
		if inputanswer == "0" :
			inputanswer = "8"
		else:	
			inputanswer = inputanswer + "8"	

func _on_button_9_pressed():
	if inputanswer.length() < 3 :
		audio_controller.play_click()
		if inputanswer == "0" :
			inputanswer = "9"
		else:	
			inputanswer = inputanswer + "9"	
		
func _on_buttonerase_pressed():
	if inputanswer.length() > 0 :
		audio_controller.play_click()
		inputanswer = inputanswer.substr(0, inputanswer.length() - 1)

func _on_button_0_pressed():
	if inputanswer.length() < 3 :
		if inputanswer != "0" :
			audio_controller.play_click()
			inputanswer = inputanswer + "0"	

func _on_buttonequal_pressed():
	if inputanswer != "":
		audio_controller.play_click()
		var input = int(inputanswer)
		if input == answer:
			enemyhp = enemyhp -1
			#play animation
			$boss.get_node("AnimatedSprite2D").play("hurt")
			audio_controller.play_ding()
		else :
			Global.playerhp = Global.playerhp - minusplayer
			#chance = chance - 1
			#play animation
			$boss.get_node("AnimatedSprite2D").play("fire")
			#flash screen here
			$AnimatedSprite2D.play("flash")
			audio_controller.play_laser()
		
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
	#audio
	audio_controller.play_laser()
	
	await get_tree().create_timer(0.5).timeout	
	$boss.get_node("AnimatedSprite2D").play("idle")

	inputanswer = ""

	if enemyhp > 0:
		generatequestion()
		$timer.start()


func win():
	await get_tree().create_timer(0.5).timeout
	audio_controller.stop_ambient_industrial()
	audio_controller.play_glass()
	get_tree().change_scene_to_file("res://scenes/transitionwin1lv1.tscn") 


func gameover():
	await get_tree().create_timer(0.5).timeout
	audio_controller.stop_ambient_industrial()
	audio_controller.play_buzzer()
	get_tree().change_scene_to_file("res://scenes/transitionbosslose.tscn") 
