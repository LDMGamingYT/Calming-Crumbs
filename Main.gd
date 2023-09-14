extends Node2D

var foods = ["apple", "baked_potato", "bread", "brick", "cooked_beef", "cooked_chicken", "cooked_cod", "cooked_mutton", "cooked_porkchop", "cooked_salmon", "cookie", "melon_slice", "sweet_berries", "apple", "baked_potato", "bread", "cooked_beef", "cooked_chicken", "cooked_cod", "cooked_mutton", "cooked_porkchop", "cooked_salmon", "cookie", "melon_slice", "sweet_berries", "apple", "baked_potato", "bread", "cooked_beef", "cooked_chicken", "cooked_cod", "cooked_mutton", "cooked_porkchop", "cooked_salmon", "cookie", "melon_slice", "sweet_berries"]
var hunger = 100
var isDoingHungerCoolDown = true
var waste = 0
var isWasteFull = false

func _ready():
	randomize()
	$FoodTimer.start(randf())

func _process(delta):
	$HungerBar.value = hunger
	$WasteBar.value = waste
	hunger = clamp(hunger, 0, 100)
	waste = clamp(waste, 0, 100)
	if hunger <= 0 && !$Bowl.bowlCracked:
		$Bowl.die()
	if waste >= 100:
		isWasteFull = true
		print("When is the next garbage day?")
	else:
		isWasteFull = false

func _on_Timer_timeout():
	var newFood = preload("res://Food.tscn").instance()
	if isWasteFull == true:
		if randf() < 0.25:
			newFood.food = "rotten_flesh"
		else:
			newFood.food = foods[randi() % foods.size()]
	else:
		newFood.food = foods[randi() % foods.size()]
	if waste >= 90:
		if randf() < 0.05:
			newFood.food = "golden_apple"
	newFood.position.y = -128
	newFood.position.x = randf() * 768 + 128
	add_child(newFood, true)
	$FoodTimer.start(randf())


func _on_HungerTimer_timeout():
	if isDoingHungerCoolDown:
		isDoingHungerCoolDown = false
	else:
		hunger -= 1
	$HungerTimer.start(0.0675)
