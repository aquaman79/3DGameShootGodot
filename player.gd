extends CharacterBody3D

# Constantes pour la vitesse de mouvement et la sensibilité de la souris
const MOVE_SPEED = 4
const MOUSE_SENS = 0.5

# Récupérer les nœuds nécessaires au démarrage du jeu
var anim_player 
var raycast 
var is_shooting = false


func _ready():
	anim_player = $AnimationPlayer
	raycast = $RayCast3D
	# Capture du curseur de la souris pour le jeu
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	# Attendre que le personnage soit prêt (correction de l'erreur ici)
	await get_tree().create_timer(0).timeout


	# Informer tous les zombies du joueur actuel
	get_tree().call_group("zombies", "set_player", self)





func _input(event):
	# Si la souris bouge, ajustez la rotation du joueur
	if event is InputEventMouseMotion:
		rotation_degrees.y -= MOUSE_SENS * event.relative.x

func _process(delta):
	# Quitter le jeu si le bouton de sortie est pressé
	if Input.is_action_pressed("exit"):
		get_tree().quit()

	# Redémarrer le jeu si le bouton de redémarrage est pressé
	if Input.is_action_pressed("restart"):
		kill()

func _physics_process(delta):
	# Initialiser un vecteur de mouvement pour le joueur
	var move_vec = Vector3()

	# Ajuster le vecteur de mouvement selon les entrées du joueur
	if Input.is_action_pressed("move_forwards"): #clique z
		print("Moving forwards")
		move_vec.z -= 1
	if Input.is_action_pressed("move_backwards"):#clique s
		print("move_backwards")
		move_vec.z += 1
	if Input.is_action_pressed("move_left"): #clique a
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"): #clique d
		move_vec.x += 1

	# Normaliser le vecteur de mouvement pour éviter des déplacements trop rapides en diagonale
	move_vec = move_vec.normalized()

	# Faire pivoter le vecteur de mouvement en fonction de la rotation actuelle du joueur
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)

	# Déplacer le joueur en utilisant le vecteur de mouvement ajusté
	move_and_collide(move_vec * MOVE_SPEED * delta)

	# Si le joueur tire et qu'aucune animation n'est en cours, tirer sur un éventuel zombie
	if Input.is_action_pressed("shoot") and !anim_player.is_playing():
		is_shooting = true
		anim_player.play("shoot")
		var coll = raycast.get_collider()
		if raycast.is_colliding() and coll.has_method("kill"):
			print("je suis ici venant de zombie")
			coll.kill()
		is_shooting = false


func kill():
	# Recharger la scène actuelle pour redémarrer le jeu
	get_tree().reload_current_scene()
