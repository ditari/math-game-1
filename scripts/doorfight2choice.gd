extends Control

var question = ""
var answer = 0
var a = 0
var b = 0
var correctchoice = 0 #position of correctchoice
var wronganswer = 0

var chance = 3
var doorhp = 2

var rng = RandomNumberGenerator.new()	

var generatenext = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	generatequestion()
	generatewronganswer()
	generatechoice()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#update bar
	$doorprogressbar.value = doorhp
	$playerprogressbar.value = Global.playerhp
	$chancelabel.text = "chance : " + str(chance) + "/3"

	if chance == 0 :
		_lose()
	elif doorhp == 0:
		_win()	
	
	#else
	if generatenext == 1:
		generatenext = 0
		generatequestion()
		generatewronganswer()
		generatechoice()

func generatequestion():
	var operation = rng.randi_range(0, 1)

	#penjumlahan
	if operation == 1:
		a = rng.randi_range(0, 10)
		b = rng.randi_range(0, 10) 
		answer = a+b
		question = str(a) + " + " + str(b)
	#pengurangan
	else : 
		answer = rng.randi_range(0, 10)		
		b = rng.randi_range(0, 10)
		a = answer + b		
		question = str(a) + " - " + str(b)
	
	$questionlabel.text = question
	
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
	else:
		Global.playerhp = Global.playerhp - 5
		chance = chance - 1
	
	generatenext = 1
		
		
func _on_button_2_pressed():
	if correctchoice == 2:
		doorhp = doorhp - 1
	else:
		Global.playerhp = Global.playerhp - 5
		chance = chance - 1
				
	generatenext = 1



#jika win fight
func _win():
	var n = Global.currentdoor
	Global.arraydooropen[n] = 1
	
	print("door open")
	
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 



#jika lose
func _lose():
	
	print ("door is still locked")

	get_tree().change_scene_to_file("res://scenes/level1.tscn") 
