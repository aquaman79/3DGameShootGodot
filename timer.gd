extends Node

var time_passed = 0.0

func _ready():
	var timer = $Timer  # Assurez-vous que le Timer est bien nommé 'Timer'
	if timer != null:
		timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
		timer.start(1.0)  # Le timer comptera en secondes
	else:
		print("Timer node not found")

func _on_Timer_timeout():
	time_passed += 1
	var label = $Label  # Assurez-vous que le Label est bien nommé 'Label'
	if label != null:
		label.text = "Temps passé :"+str(time_passed) + " sec"
	else:
		print("Label node not found")
