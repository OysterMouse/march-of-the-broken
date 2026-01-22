@tool
class_name Unit
extends Area2D

@export var unit_data: UnitData
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready():

	sprite_2d.texture = unit_data.icon

	if unit_data.flip_icon:
		sprite_2d.flip_h = true

	if unit_data:
		print("Unit Name: %s" % unit_data.unit_name)
		print("Health: %d" % unit_data.health)
		print("Attack Power: %d" % unit_data.attack_power)
		print("Defense: %d" % unit_data.defense)
		print("Speed: %.2f" % unit_data.speed)
		print("Abilities: %s" % unit_data.abilities)
		print("Description: %s" % unit_data.description)
		
		
	else:
		print("No unit data assigned.")
