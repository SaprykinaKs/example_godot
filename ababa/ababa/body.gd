extends CharacterBody2D

var SPEED = 20

var direction = Vector2(1, 5) 

func _ready():
	set_process(true)

func _process(delta):
	var velocity = SPEED * direction 
	var collision = move_and_collide(velocity * delta)
	if collision:
		var temp = -0.5 * direction.y - 0.8 * direction.x
		var temp2 = 0.866 * direction.x - 0.5 * direction.y
		direction.x = temp
		direction.y = temp2
		if direction.x < 0 && $Ababa.scale.x> 0:
			$Ababa.scale.x = - $Ababa.scale.x
		if direction.x > 0 && $Ababa.scale.x<0 :
			$Ababa.scale.x = - $Ababa.scale.x

