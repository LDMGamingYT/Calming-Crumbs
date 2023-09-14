extends RigidBody2D

var food = "" # Determines the food type
var foods = {"apple": [Vector2(1,-7), Vector2(-5,-3), Vector2(-6,-2), Vector2(-6,3), Vector2(-5,5), Vector2(-3,7), Vector2(3,7), Vector2(5,5), Vector2(6,3), Vector2(6,-2), Vector2(5,-3), Vector2(2,-5), Vector2(2,-7)], # Dictionary of foods
 "baked_potato": [Vector2(-1,-5), Vector2(-3,-4), Vector2(-5,-2), Vector2(-6,0), Vector2(-6,4), Vector2(-3,7), Vector2(1,7), Vector2(5,5), Vector2(7,3), Vector2(7,-1), Vector2(6,-3), Vector2(4,-5)],
 "bread": [Vector2(1,-7), Vector2(-1,-6), Vector2(-6,-1), Vector2(-7,1), Vector2(-7,6), Vector2(-5,8), Vector2(-1,8), Vector2(7,0), Vector2(7,-5), Vector2(5,-7)],
 "brick": [Vector2(2,-6), Vector2(-7,-3), Vector2(-8,-2), Vector2(-8,3), Vector2(-5,6), Vector2(-1,6), Vector2(5,4), Vector2(7,3), Vector2(8,2), Vector2(8,-2), Vector2(4,-6)],
 "cooked_beef": [Vector2(1,-5), Vector2(-2,-2), Vector2(-4,-1), Vector2(-5,0), Vector2(-6,2), Vector2(-6,4), Vector2(-5,6), Vector2(-3,7), Vector2(1,7), Vector2(3,6), Vector2(6,3), Vector2(7,1), Vector2(7,-3), Vector2(5,-5)],
 "cooked_chicken": [Vector2(-3,-7), Vector2(-4,-6), Vector2(-5,-4), Vector2(-6,-1), Vector2(-6,5), Vector2(-4,7), Vector2(0,7), Vector2(2,6), Vector2(3,5), Vector2(5,4), Vector2(6,3), Vector2(7,1), Vector2(7,-2), Vector2(3,-6), Vector2(1,-7)],
 "cooked_cod": [Vector2(3,-7), Vector2(0,-4), Vector2(-2,-3), Vector2(-5,0), Vector2(-6,2), Vector2(-6,6), Vector2(-5,7), Vector2(-2,7), Vector2(7,-2), Vector2(7,-5), Vector2(5,-7)],
 "cooked_mutton": [Vector2(3,-7), Vector2(2,-6), Vector2(0,-2), Vector2(-2,0), Vector2(-3,0), Vector2(-6,3), Vector2(-6,7), Vector2(-5,8), Vector2(1,8), Vector2(3,7), Vector2(4,6), Vector2(5,4), Vector2(6,0), Vector2(6,-6), Vector2(5,-7)],
 "cooked_porkchop": [Vector2(1,-5), Vector2(-6,2), Vector2(-6,4), Vector2(-5,6), Vector2(-3,7), Vector2(1,7), Vector2(2,6), Vector2(4,5), Vector2(6,3), Vector2(7,1), Vector2(7,-3), Vector2(5,-5)],
 "cooked_salmon": [Vector2(3,-7), Vector2(2,-5), Vector2(0,-4), Vector2(-3,-4), Vector2(-4,-3), Vector2(-5,0), Vector2(-6,2), Vector2(-6,6), Vector2(-4,7), Vector2(-2,7), Vector2(0,6), Vector2(3,3), Vector2(4,1), Vector2(5,-2), Vector2(7,-3), Vector2(7,-5), Vector2(5,-7)],
 "cookie": [Vector2(-3,-6), Vector2(-5,-5), Vector2(-7,-3), Vector2(-7,3), Vector2(-5,5), Vector2(-3,6), Vector2(3,6), Vector2(5,5), Vector2(7,3), Vector2(7,-3), Vector2(5,-5), Vector2(3,-6)],
 "golden_apple": [Vector2(1,-7), Vector2(-5,-3), Vector2(-6,-2), Vector2(-6,3), Vector2(-5,5), Vector2(-3,7), Vector2(3,7), Vector2(5,5), Vector2(6,3), Vector2(6,-2), Vector2(5,-3), Vector2(2,-5), Vector2(2,-7)],
 "melon_slice": [Vector2(2,-6), Vector2(-7,3), Vector2(-7,5), Vector2(-5,7), Vector2(1,7), Vector2(3,6), Vector2(5,4), Vector2(6,2), Vector2(6,-4), Vector2(4,-6)],
 "rotten_flesh": [Vector2(2,-7), Vector2(0,-6), Vector2(-2,-4), Vector2(-7,2), Vector2(-7,4), Vector2(-4,7), Vector2(-2,7), Vector2(4,5), Vector2(7,2), Vector2(8,-2), Vector2(8,-4), Vector2(5,-5), Vector2(4,-7)],
 "sweet_berries": [Vector2(-2,-6), Vector2(-6,-3), Vector2(-7,3), Vector2(-7,5), Vector2(-2,6), Vector2(1,6), Vector2(6,3), Vector2(7,-1), Vector2(7,-3), Vector2(6,-4), Vector2(1,-6)]}


func _ready():
	$Sprite.texture = load("res://sprites/%s.png" % food)
	if food == "golden_apple":
		$Sprite.modulate = Color(1.25, 1.25, 0)
	$CollisionPolygon2D.polygon = foods[food]
	physics_material_override = PhysicsMaterial.new()
	physics_material_override.bounce = 0.375
	if food == "brick":
		physics_material_override.bounce = 0
		gravity_scale = 10

func disappear():
	$AnimationPlayer.play("Disappear")

func shrink():
	physics_material_override.bounce = 0
	$AnimationPlayer.play("Shrink")

func _on_Timer_timeout():
	disappear()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Disappear":
		if food == "brick":
			pass
		else:
			get_parent().waste += randi() % 11
	if anim_name != "Disappear" && anim_name != "Shrink":
		return
	queue_free()

