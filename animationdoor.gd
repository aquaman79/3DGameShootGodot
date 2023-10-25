extends Node3D

var isOpen = false



func _ready():
	pass

func open_door():
	isOpen = true
	print("je suis ici")
	$AnimationPlayer.play("porteAnim")

	# Ici, si vous avez une logique supplémentaire pour ouvrir la porte (par exemple, jouer un son), ajoutez-la
	# Sinon, le HingeJoint3D que vous avez configuré manuellement devrait permettre à la porte de s'ouvrir naturellement
	
	#joint.motor_target_velocity = -10.0  # Si vous voulez que la porte se ferme automatiquement
	# Ajoutez la logique de fermeture de la porte ici si nécessaire

func _on_area_3d_body_entered(body):
	if body.name == "Player" and not isOpen:
		open_door()
