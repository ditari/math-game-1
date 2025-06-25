extends Control

var circlescene: PackedScene = load("res://scenes/circle.tscn")

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

var circle

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	generatequestion()
	
	generatecircle(1,answerarray[1])
	generatecircle(2,answerarray[2])
	generatecircle(3,answerarray[3])
	generatecircle(4,answerarray[4])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
	
	$Sprite2D/label3.text = str(answer)
	
	
func generatecircle(indexpos,value):
	circle = circlescene.instantiate()
	
	if indexpos == 1:
		circle.position = Vector2(25,900)
		circle.index = 1 
	elif indexpos == 2:
		circle.position = Vector2(200,900)
		circle.index = 2
	elif indexpos == 3:
		circle.position = Vector2(375,900)
		circle.index = 3 
	else:
		circle.position = Vector2(550,900)
		circle.index = 4 
	
	$array.add_child(circle)	
	
	var label = circle.get_node("label")
	label.text = str(value)
	
	circle.connect("button_pressed", circlepressed)

func circlepressed(index):
	#print("here")
	clicked = clicked + 1
	if clicked == 1:
		indexa = index
		$Sprite2D/label1.text = str (answerarray[index])
	if clicked == 2:
		indexb = index
		$Sprite2D/label2.text = str (answerarray[index])
	


func _on_button_2_pressed():
	for child in $array.get_children():
		child.queue_free()

	generatecircle(1,answerarray[1])
	generatecircle(2,answerarray[2])
	generatecircle(3,answerarray[3])
	generatecircle(4,answerarray[4])
	
	$Sprite2D/label1.text = "???"
	$Sprite2D/label2.text = "???"

	clicked = 0


func _on_button_pressed():
	if clicked == 2:
		if answerarray[indexa] + answerarray[indexb] == answer:
			print("correct answer")
			var reward = 100 #randi_range(50,100)
			print("you get" + str(reward))
			Global.score=Global.score+reward
		else :
			print("wrong answer")
			
	get_tree().change_scene_to_file("res://scenes/level1.tscn") 
