extends CharacterBody3D


const MOVE_SPEED = 3
 
var raycast 
var anim_player 
 
var player = null
var dead = false
signal zombie_hit_player

 
func _ready():
	raycast = $RayCast3D 
	anim_player = $AnimationPlayer
	anim_player.play("walk")
	add_to_group("zombies")
 
func _physics_process(delta):
	if dead:
		return
	if player == null:
		return
 
	var vec_to_player 
	vec_to_player = player.global_transform.origin - global_transform.origin
	vec_to_player = vec_to_player.normalized()
	raycast.target_position = global_transform.origin + vec_to_player * 1.5

 
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
 
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll != null and coll.name == "Player" and !coll.is_shooting:
			#emit_signal("zombie_hit_player")
			kill()

 
 
func kill():
	#print("player")
	dead = true
	$CollisionShape3D.disabled = true
	anim_player.play("die")
 
func set_player(p):
	player = p
