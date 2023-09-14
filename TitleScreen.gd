extends Control

func _on_Play_pressed():
	$FadeAnim.play_backwards("Fade")
	yield($FadeAnim, "animation_finished")
	get_tree().change_scene("res://Main.tscn")
