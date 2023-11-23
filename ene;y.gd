extends CharacterBody3D


const MOVE_SPEED = 3
const DETECTION_DISTANCE = 20  # Distance à laquelle le zombie détecte le joueur
const FIELD_OF_VIEW = 45  # Angle de champ de vision en degrés
const MIN_DISTANCE_TO_PLAYER = 1.5  # Définissez une distance minimale pour considérer que le joueur est attrapé

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
	if dead or player == null:
		return

	var vec_to_player = player.global_transform.origin - global_transform.origin
	var distance_to_player = vec_to_player.length()
	vec_to_player = vec_to_player.normalized()

	# Mise à jour de la position cible du raycast
	raycast.target_position = global_transform.origin + vec_to_player * 1.5
	
	# Vérifiez si la distance est suffisamment proche pour attraper le joueur
	if distance_to_player <= MIN_DISTANCE_TO_PLAYER:
		print("Game Over")
		show_game_over_interface()
		# Vous pouvez ajouter ici d'autres logiques, comme finir le jeu ou recharger la scène
		return

	if distance_to_player <= DETECTION_DISTANCE :
		anim_player.play("walk")
		move_and_collide(vec_to_player * MOVE_SPEED * delta)
	else:
		anim_player.play("walk")
		##move_and_collide(vec_to_player * MOVE_SPEED * delta)

	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll != null and coll.name == "Player" and !coll.is_shooting:
			kill()



func show_game_over_interface():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
	get_tree().change_scene_to_file("res://control.tscn")

# Fonction pour vérifier si le joueur est dans le champ de vision du zombie
func is_player_in_view(vec_to_player):
	var direction_to_player = vec_to_player.normalized()
	var forward_direction = Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
	return forward_direction.dot(direction_to_player) > cos(deg_to_rad((FIELD_OF_VIEW / 2)))
 
func kill():
	#print("player")
	dead = true
	$CollisionShape3D.disabled = true
	anim_player.play("die")
 
func set_player(p):
	player = p
