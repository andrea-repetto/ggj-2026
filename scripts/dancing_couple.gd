class_name DancingCouple
extends Node


var dancers: Array[Node2D] = []
var player: Character = null


func initialize(_dancers: Array[Node2D]) -> void:
	dancers = _dancers
	var player_index := dancers.find_custom(func (dancer): return dancer is Character)
	if player_index >= 0:
		player = dancers[player_index] as Character
		player.notification(NOTIFICATION_DISABLED)
	
	for dancer in dancers:
		dancer.get_parent().remove_child.call_deferred(dancer)
		add_child.call_deferred(dancer)


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		if is_instance_valid(player):
			player.notification(NOTIFICATION_ENABLED)
		
		for dancer in dancers:
			remove_child(dancer)
			get_parent().add_child(dancer)
