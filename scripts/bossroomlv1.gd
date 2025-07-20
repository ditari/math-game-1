extends Control

#var bgwallscene: PackedScene = load("res://scenes/bgwall.tscn")
#var bgwall

var bossscene: PackedScene = load("res://scenes/bosslv1.tscn")
var boss
# Called when the node enters the scene tree for the first time.
func _ready():
	#bgwall = bgwallscene.instantiate()
	#bgwall.position = Vector2(0,128)
	#$array.add_child(bgwall)
	
	$playerprogressbar.value = Global.playerhp	
	$scorelabel.text = "Score: " +str (Global.score)

	if Global.items[1] > 0:
		$key1.get_node("AnimatedSprite2D").play("on")	
	if Global.items[2] > 0:
		$key2.get_node("AnimatedSprite2D").play("on")
	
	$key1label.text = str(Global.items[1])
	$key2label.text = str(Global.items[2])	
		
	#calculator	
	if Global.calculator == 0:
		$calculator.visible = false
		$calculatorlabel.visible = false
	else:
		$calculatorlabel.text = str (Global.calculator)

	#boss
	boss = bossscene.instantiate()
	boss.position = Vector2(264,600)
	boss.scale = Vector2(1.5,1.5)
	
	boss.connect("button_pressed", _on_button_pressed)
	
	$array.add_child(boss)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/bossfightlv1.tscn") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
