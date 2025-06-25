extends Node2D


# Called when the node enters the scene tree for the first time.
signal button


#func _on_button_pressed():
#	emit_signal("button_pressed", index)
#	queue_free()
#

#func _on_button_pressed():
#	emit_signal("button_pressed")
#

func _on_button_pressed():
	emit_signal("button")
