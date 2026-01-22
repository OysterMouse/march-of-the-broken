@tool
class_name Enemy
extends Area2D

@export var enemy_data : EnemyData
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	if enemy_data:
		sprite_2d.texture = enemy_data.icon
		
		# Set collision shape to match texture size
		if enemy_data.icon:
			var texture_size = enemy_data.icon.get_size()
			var shape = RectangleShape2D.new()
			shape.size = texture_size
			collision_shape_2d.shape = shape
		print("Damage: %d" % enemy_data.damage)
		print("Defense: %d" % enemy_data.defense)
		print("Speed: %.2f" % enemy_data.speed)
		print("Abilities: %s" % enemy_data.abilities)
		print("Description: %s" % enemy_data.description)
	else:
		print("No enemy data assigned.")
