extends Node

export(PackedScene) var _mob = preload("res://Mob.tscn")




func _ready():
	start_game()




func start_game():
	$Player.init()
	$GUI.on_new_game()
	$MobDelay.start()
	$Sounds/GameMusic.play()




func _on_MobDelay_timeout():
	var mob = _mob.instance()
	add_child(mob)




func _on_Player_game_over():
	$Sounds/GameMusic.stop()
	$Sounds/GameOver.play()
	$GUI.show_message("GAME OVER")
#	$GUI/ScoreLabel.hide()
	$MobDelay.stop()
	yield($GUI/MessageTimer, "timeout")
	$GUI/ScoreLabel.hide()

