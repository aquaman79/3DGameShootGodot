extends Node3D

var isOpen = false
@onready var joint = $HingeJoint3D
const MOTOR_TARGET_VELOCITY = 14



func _ready():
	pass

func open_door():
	isOpen = true
	print("je suis ici")
	joint.set_param(MOTOR_TARGET_VELOCITY, 10.0)  # Augmentez cette valeur pour accélérer l'ouverture

	# Ici, si vous avez une logique supplémentaire pour ouvrir la porte (par exemple, jouer un son), ajoutez-la
	# Sinon, le HingeJoint3D que vous avez configuré manuellement devrait permettre à la porte de s'ouvrir naturellement
	
	#joint.motor_target_velocity = -10.0  # Si vous voulez que la porte se ferme automatiquement
	# Ajoutez la logique de fermeture de la porte ici si nécessaire

func _on_area_3d_body_entered(body):
	if body.name == "Player" and not isOpen:
		open_door()
