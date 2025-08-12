extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_ambient_industrial():
	$ambient_industrial.play()

func stop_ambient_industrial():
	$ambient_industrial.stop()

func play_beep():
	$beep.play()

func play_bling():
	$bling.play()

func play_buzzer():
	$buzzer.play()

func play_click():
	$click.play()
	
func play_clock_tick_slow():
	$clock_tick_slow.play()

func stop_clock_tick_slow():
	$clock_tick_slow.stop()

func play_ding():
	$ding.play()

func play_doorbell():
	$doorbell.play()

func play_door_open():
	$door_open.play()
	
func play_electric():
	$electric.play()
	
func play_glass():
	$glass.play()
	
func play_gunshot():
	$gunshot.play()
	
func play_laser():
	$laser.play()

func play_mechanical_key():
	$mechanical_key.play()
	
func play_mechanical_keyboard_1():
	$mechanical_keyboard_1.play()
	
func play_mechanical_keyboard_3():
	$mechanical_keyboard_3.play()
	
func play_reload():
	$reload.play()

func play_sliding_door():
	$sliding_door.play()

func play_you_lost():
	$you_lost.play()

func play_you_won():
	$you_won.play()
