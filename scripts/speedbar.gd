extends ProgressBar

func _ready():
	
	pass


func _on_Spinner_speed( value ):
	set_value(value * get_max())
