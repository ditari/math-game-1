extends Control

var question = ""
var answer = 0
var a = 0
var b = 0
var correctchoice = 0 #position of correctchoice
var wronganswer = 0

var chance = 3
var doorhp = 2
var minusplayer = 5

var rng = RandomNumberGenerator.new()	

var generatenext = 0

var xgaps
var ygaps

#var door = get_node("door")

# Called when the node enters the scene tree for the first time.
func _ready():
	#position sprite
	update_sprite()
	
	#calculator
	if Global.calculator == 0:
		$calculator.visible = false
		$calculator/calculatorlabel.visible = false
	else :
		$calculator/calculatorlabel.text = str(Global.calculator)	
	$calculator.button_pressed.connect(_on_calculator_button_pressed)	
	
	generatequestion()
	generatewronganswer()
	generatechoice()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#calculator
	if Global.calculator == 0:
		$calculator.visible = false
		$calculator/calculatorlabel.visible = false
	else :
		$calculator/calculatorlabel.text = str(Global.calculator)	
	
	#update bar
	$doorprogressbar.value = doorhp
	$playerprogressbar.value = Global.playerhp
	#$chancelabel.text = "chance : " + str(chance) + "/3"

	if Global.playerhp > 0 :
		if chance == 0 :
			lose()
		elif doorhp == 0:
			win()
	else :
		lose()
			
	#else
	if generatenext == 1:
		generatenext = 0
		generatequestion()
		generatewronganswer()
		generatechoice()

func update_sprite():
	var screen_size = get_viewport_rect().size
	ygaps = screen_size.y/10
	#print (ygaps)
	
	$calculator.position.x = screen_size.x - 128
	$calculator.position.y = ygaps - 112
	
	$doorprogressbar.position.x = (screen_size.x - 300)/2
	$doorprogressbar.position.y = ygaps - 16
	
	$door.position.x = (screen_size.x - 128)/2 -32
	$door.position.y = ygaps+ 48
	
	#$electric.position.x = (screen_size.x - 128)/2 -32
	#$electric.position.y = ygaps+ 48
	
	$questionlabel.position.y = 4*ygaps + 72
	$answerlabel.position.y = 5*ygaps + 72
	
	xgaps = (screen_size.x - 384) / 3 
	$Button1.position.x = xgaps
	$Button1.position.y = 7*ygaps
	
	$Button2.position.x = 2*xgaps + 192
	$Button2.position.y = 7*ygaps
	
	$hplabel.position.x = 32
	$hplabel.position.y = 9*ygaps#8*ygaps + 60

	$playerprogressbar.position.x = 192
	$playerprogressbar.position.y = 9*ygaps + 16 #8*ygaps + 72
	

#autoanswer
func _on_calculator_button_pressed():
	Global.calculator = Global.calculator - 1

	doorhp = doorhp - 1
	$answerlabel.text = str (answer)
		
	$door.get_node("AnimatedSprite2D").play("hurt")
	
	#wait dulu
	await get_tree().create_timer(0.5).timeout
	$door.get_node("AnimatedSprite2D").play("close")

	generatenext = 1
	$answerlabel.text = ""

func generatequestion():
	var operation = rng.randi_range(0, 1)

	#penjumlahan
	if operation == 1:
		a = rng.randi_range(0, 5)
		b = rng.randi_range(0, 5) 
		answer = a+b
		question = str(a) + " + " + str(b)
	#pengurangan
	else : 
		answer = rng.randi_range(0, 5)		
		b = rng.randi_range(0, 5)
		a = answer + b		
		question = str(a) + " - " + str(b)
	
	$questionlabel.text = question + " = ?"
	
func generatechoice():
	correctchoice = rng.randi_range(1, 2)	
	
	if correctchoice == 1:
		$Button1/Label1.text = str(answer)
		$Button2/Label2.text = str(wronganswer)
	else:
		$Button1/Label1.text = str(wronganswer)
		$Button2/Label2.text = str(answer)	
	
func generatewronganswer ()	:
	if answer== 0:
		wronganswer = rng.randi_range(1, 5) 
	else : 	
		var bias = rng.randi_range(1, answer) #rng.randi_range(1, round(answer*0.6)) ini 1 selalu jaraknya 2
		
		var v = rng.randi_range(1, 2)
		if v == 1:
			wronganswer = answer + bias
		else :
			wronganswer = answer - bias	



func _on_button_1_pressed():
	if correctchoice == 1:
		doorhp = doorhp - 1
		$answerlabel.text = str (answer)
		
		$door.get_node("AnimatedSprite2D").play("hurt")
		
	else:
		Global.playerhp = Global.playerhp - minusplayer
		chance = chance - 1
		$answerlabel.text = str (wronganswer)
		
		$AnimatedSprite2D.play("flash")
		$door/electric.play("on")
		
	#wait dulu
	await get_tree().create_timer(0.5).timeout
	$door.get_node("AnimatedSprite2D").play("close")

	generatenext = 1
	$answerlabel.text = ""	
		
func _on_button_2_pressed():
	if correctchoice == 2:
		doorhp = doorhp - 1
		$answerlabel.text = str (answer)
		
		$door.get_node("AnimatedSprite2D").play("hurt")
	else:
		Global.playerhp = Global.playerhp - minusplayer
		chance = chance - 1
		$answerlabel.text = str (wronganswer)
		
		$AnimatedSprite2D.play("flash")
		$door/electric.play("on")

	#wait dulu
	await get_tree().create_timer(0.5).timeout				
	$door.get_node("AnimatedSprite2D").play("close")

	generatenext = 1
	$answerlabel.text = ""


#jika win fight
func win():
	var n = Global.currentdoor
	Global.arraydooropen[n] = 1
	
	Global.currentdooropened = n
	
	#print("door open")
	await get_tree().create_timer(0.5).timeout		
	get_tree().change_scene_to_file("res://scenes/transitionwindoor.tscn") 



#jika lose
func lose():	
	#print ("door is still locked")
	await get_tree().create_timer(0.5).timeout	
	get_tree().change_scene_to_file("res://scenes/transitionlosedoor.tscn") 

#func gameover():
#	await get_tree().create_timer(0.5).timeout	
#	get_tree().change_scene_to_file("res://scenes/gameover.tscn")
