extends Control

#var bgwallscene: PackedScene = load("res://scenes/bgwall.tscn")
#var bgwall
var ygaps
var xgaps

var bossscene: PackedScene = load("res://scenes/bosslv1.tscn")
var boss
# Called when the node enters the scene tree for the first time.
func _ready():
	#bgwall = bgwallscene.instantiate()
	#bgwall.position = Vector2(0,128)
	#$array.add_child(bgwall)
	update_sprite()
	
	$playerprogressbar.value = Global.playerhp	
	$scorelabel.text = "SCORE: " +str (Global.score)

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
	boss.position = Vector2(xgaps-32,5*ygaps)
	boss.scale = Vector2(1.5,1.5)
	
	boss.connect("button_pressed", _on_button_pressed)
	
	$array.add_child(boss)
	
	#audio_controller.play_ambient_industrial()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_sprite():
	var screen_size = get_viewport_rect().size
	ygaps = screen_size.y/10
	xgaps = (screen_size.x - 128)/2
	
	$Bgwall.position.x = 360
	$Bgwall.position.y = ygaps + 192
	
	$scorelabel.position.y = 0.3 * ygaps
	
	$hplabel.position.x = 32
	$hplabel.position.y = 8*ygaps + 60
	
	$playerprogressbar.position.x = 192
	$playerprogressbar.position.y = 8*ygaps + 72
	
	$itemlabel.position.x = 32
	$itemlabel.position.y = 9*ygaps + 16
	
	$key1.position.x = 192
	$key1.position.y = 9*ygaps

	$key1label.position.x =256
	$key1label.position.y =9*ygaps
	
	$key2.position.x = 368 #384
	$key2.position.y = 9*ygaps	
	
	$key2label.position.x =432 #448
	$key2label.position.y =9*ygaps	
	
	$calculator.position.x = 544
	$calculator.position.y = 9*ygaps
	
	$calculatorlabel.position.x = 608
	$calculatorlabel.position.y = 9*ygaps	

func _on_button_pressed():
	#audio_controller.stop_ambient_industrial()
	audio_controller.play_reload()

	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/bossfightlv1.tscn") 
