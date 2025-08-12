extends Control

var boxscene: PackedScene = load("res://scenes/box.tscn")

var answerarray 

#position of the correct answer
var index1
var index2

#answer yg sedang dipilih
var indexa
var indexb
var answer

#untuk cek apakah sedang isi indexa atau indexb
var clicked = 0

var box
var ygaps

var rng = RandomNumberGenerator.new()

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
	
	generatebox(1,answerarray[1])
	generatebox(2,answerarray[2])
	generatebox(3,answerarray[3])
	generatebox(4,answerarray[4])
	
	#audio
	#audio_controller.play_ambient_industrial()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#calculator
	if Global.calculator == 0:
		$calculator.visible = false
		$calculator/calculatorlabel.visible = false
	else :
		$calculator/calculatorlabel.text = str(Global.calculator)
	
	
	if clicked == 2:
		$Button2/reloadbg.play("on")
		$Button/enterbg.play("on")
	else :
		$Button2/reloadbg.play("off")
		$Button/enterbg.play("off")
		
func update_sprite():
	var screen_size = get_viewport_rect().size
	ygaps = screen_size.y/10
	#var xgaps = (screen_size.x - 192)/2

	$calculator.position.x = screen_size.x - 128
	$calculator.position.y = ygaps - 112
	
	$screen.position.y = ygaps + 224	

	$Button.position.x = 112
	$Button.position.y = 5*ygaps - 32 	#position x nya nyerah

	$Button2.position.x = 480	
	$Button2.position.y = 5*ygaps - 32
	
	#print(ygaps)
		
#autoanswer		
func _on_calculator_button_pressed():
	audio_controller.play_ding()
	#delete semua button dulu
	for child in $array.get_children():
		child.queue_free()

	#generate hanya button wrong answer
	for i in range(1, 5) :
		if i != index1 and i !=index2:
			generatebox(i,answerarray[i])

	Global.calculator = Global.calculator - 1 
	
	$screen/box1/label1.text = str (answerarray[index1])
	$screen/box2/label2.text = str (answerarray[index2])
	
	indexa = index1
	indexb = index2
	clicked = 2
		
#func _delete_box_with_index(target_index):
#	for child in $array.get_children():
#		if child.index == target_index:
#			child.queue_free()
#			break
			
		
func generatequestion():
	#location of the correct index
	index1 = rng.randi_range(1, 4)

	index2 = index1
	while index2 == index1:
		index2  = rng.randi_range(1, 4)
	
	#generate all numbers in array
	randomize()
	var numbers = range(11)  # [0, 1, ..., 10]
	numbers.shuffle()
	
	answerarray = numbers.slice(0, 5) 
	answer = answerarray[index1]+answerarray[index2]
	
	$screen/box3/label3.text = str(answer)
	
	
func generatebox(indexpos,value):
	box = boxscene.instantiate()
	
	if indexpos == 1:
		box.position = Vector2(150,7*ygaps - 96) #nyerah deh x pos nya
		box.index = 1 
	elif indexpos == 2:
		box.position = Vector2(400,7*ygaps - 96)#Vector2(380,800)
		box.index = 2
	elif indexpos == 3:
		box.position = Vector2(150,8*ygaps+16)#Vector2(170,1000)
		box.index = 3 
	else:
		box.position = Vector2(400,8*ygaps+16) #Vector2(380,1000)
		box.index = 4 
	
	box.scale=Vector2(1.2,1.2)
	
	$array.add_child(box)	
	
	var label = box.get_node("label")
	label.text = str(value)
	
	box.connect("button_pressed", boxpressed)

func boxpressed(index):
	audio_controller.play_click()
	#print("here")
	clicked = clicked + 1
	if clicked == 1:
		indexa = index
		$screen/box1/label1.text = str (answerarray[index])
	if clicked == 2:
		indexb = index
		$screen/box2/label2.text = str (answerarray[index])
	


func _on_button_2_pressed():
	audio_controller.play_click()
	for child in $array.get_children():
		child.queue_free()

	for i in range(1, 5) :
		generatebox (i, answerarray[i])
	#generatebox(1,answerarray[1])
	
	$screen/box1/label1.text = "??"
	$screen/box2/label2.text = "??"

	clicked = 0


func _on_button_pressed():
	if clicked == 2:
		Global.whatexist = 3
		#audio_controller.stop_ambient_industrial()
		
		if answerarray[indexa] + answerarray[indexb] == answer:			
			audio_controller.play_glass()
			get_tree().change_scene_to_file("res://scenes/transitionpuzzlewinlv1.tscn") 
		else :
			audio_controller.play_buzzer()
			get_tree().change_scene_to_file("res://scenes/transitionpuzzleloselv1.tscn") 
			
	#get_tree().change_scene_to_file("res://scenes/level1.tscn") 
