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

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	generatequestion()
	
	generatebox(1,answerarray[1])
	generatebox(2,answerarray[2])
	generatebox(3,answerarray[3])
	generatebox(4,answerarray[4])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if clicked == 2:
		$reloadbg.play("on")
		$enterbg.play("on")
	else :
		$reloadbg.play("off")
		$enterbg.play("off")
		
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
		box.position = Vector2(150,780) #Vector2(170,800)
		box.index = 1 
	elif indexpos == 2:
		box.position = Vector2(400,780)#Vector2(380,800)
		box.index = 2
	elif indexpos == 3:
		box.position = Vector2(150,1020)#Vector2(170,1000)
		box.index = 3 
	else:
		box.position = Vector2(400,1020) #Vector2(380,1000)
		box.index = 4 
	
	box.scale=Vector2(1.2,1.2)
	
	$array.add_child(box)	
	
	var label = box.get_node("label")
	label.text = str(value)
	
	box.connect("button_pressed", boxpressed)

func boxpressed(index):
	#print("here")
	clicked = clicked + 1
	if clicked == 1:
		indexa = index
		$screen/box1/label1.text = str (answerarray[index])
	if clicked == 2:
		indexb = index
		$screen/box2/label2.text = str (answerarray[index])
	


func _on_button_2_pressed():
	for child in $array.get_children():
		child.queue_free()

	generatebox(1,answerarray[1])
	generatebox(2,answerarray[2])
	generatebox(3,answerarray[3])
	generatebox(4,answerarray[4])
	
	$screen/box1/label1.text = "??"
	$screen/box2/label2.text = "??"

	clicked = 0


func _on_button_pressed():
	if clicked == 2:
		Global.whatexist = 3
		
		if answerarray[indexa] + answerarray[indexb] == answer:
			#print("correct answer")
			#var reward = 100 #randi_range(50,100)
			#print("you get" + str(reward))
			#Global.score=Global.score+reward
			get_tree().change_scene_to_file("res://scenes/transitionpuzzlewinlv1.tscn") 
		else :
			get_tree().change_scene_to_file("res://scenes/transitionpuzzleloselv1.tscn") 
			
	#get_tree().change_scene_to_file("res://scenes/level1.tscn") 
