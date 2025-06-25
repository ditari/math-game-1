extends Node2D

var index


# Called when the node enters the scene tree for the first time.
signal button_pressed(index)


func _on_button_pressed():
	emit_signal("button_pressed", index)
	queue_free()
