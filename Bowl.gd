extends Area2D

var bowlCracked = false

func _process(delta):
	if bowlCracked:
		return
	position.x = get_global_mouse_position().x

func _on_Bowl_body_entered(body):
	if body.name == "Floor":
		return
	if body.name == "Walls":
		return
	if body.food == "brick":
		die()
	if body.food == "golden_apple":
		get_parent().waste = 0
		for child in get_parent().get_children():
			if child is RigidBody2D && child.food == "rotten_flesh" or child is RigidBody2D && child.food == "golden_apple":
				child.disappear()
	if body.food == "rotten_flesh":
		get_parent().hunger -= 12.5
	body.shrink()
	get_parent().hunger += 10

func die():
	get_parent().get_node("FoodTimer").stop()
	get_parent().get_node("HungerTimer").stop()
	bowlCracked = true
	for child in get_parent().get_children():
		if child is RigidBody2D:
			child.disappear()
	$Sprite.texture = load("res://sprites/cracked_bowl.png")
	$Timer.start()
	yield($Timer, "timeout")
	get_parent().get_node("FadeAnim").play_backwards("Fade")
	yield(get_parent().get_node("FadeAnim"), "animation_finished")
	get_tree().reload_current_scene()
