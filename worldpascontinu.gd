extends Node3D

var lampe_node
var player_node
var distance_label  # Référence au Label pour afficher la distance


func _ready():
	var audio_player = $AudioStreamPlayer
	# Initialisation des nœuds
	lampe_node = get_node("GridMap/Node3D")  # Chemin adapté pour accéder à la lampe
	player_node = get_node("Player/Player/Camera3D")  # Chemin adapté pour accéder au joueur
	distance_label = get_node("Control/Label")  # Assurez-vous de mettre le bon chemin vers votre Label
	audio_player.play()


func _physics_process(delta):
	# Vérifiez si les nœuds sont correctement référencés

	# Assumer que la caméra suit le joueur et utiliser la position du joueur
	var camera_position = player_node.global_transform.origin

	# Calculer la distance
	var distance = lampe_node.global_transform.origin.distance_to(camera_position)
	
	# Mettre à jour le Label avec la distance formatée
	distance_label.text = "Distance: %.1f" % distance
	# Vérifier si la distance est entre 0 et 5
	if distance >= 0.0 and distance <= 5.0:
		# Transition vers la page "victory.tscn" lorsque la distance est entre 0 et 5
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Rendre la souris visible
		get_tree().change_scene_to_file("res://victory.tscn")
