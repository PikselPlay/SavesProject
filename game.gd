extends Node2D
var money = 0

var data_path  = "user://Saves.data"
var data = {
	"upgrade1": {
			"level": 0,
			"cost": 10
	},
	"upgrade2": {
			"level": 0,
			"cost": 25
	},
	"upgrade3":
		{
			"level": 1,
			"cost": 50
		}
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CenterContainer/Click.text = "  " + str(money) + "  "
	$Upgrade1.text = "Upgrade1:" + str(data["upgrade1"].cost)
	$Upgrade2.text = "Upgrade2:" + str(data["upgrade2"].cost)
	$Upgrade3.text = "Upgrade3:" + str(data["upgrade3"].cost)


func _on_click_pressed() -> void:
	money += 1 + data["upgrade1"].level + data["upgrade2"].level * data["upgrade3"].level

func _save():
	var config = ConfigFile.new()
	#config.set_value("Секция","Название значения","Значение") - сохранить значение
	config.set_value("Main","money",money)
	config.set_value("Main","data",data)
	config.save(data_path)
func _load():
	var config = ConfigFile.new()
	#переменная = config.get_value("Секция","Название значения","Начальное значение") - загрузить значение
	config.load(data_path)
	money = config.get_value("Main","money",0) 
	data = config.get_value("Main","data",data)
	
	


func _on_upgrade_1_pressed() -> void:
	if money >= data["upgrade1"].cost:
		money -= data["upgrade1"].cost
		data["upgrade1"].cost = int(data["upgrade1"].cost * 1.5)
		data["upgrade1"].level += 1


func _on_upgrade_2_pressed() -> void:
	if money >= data["upgrade2"].cost:
		money -= data["upgrade2"].cost
		data["upgrade2"].cost = int(data["upgrade2"].cost * 1.5)
		data["upgrade2"].level += 1


func _on_upgrade_3_pressed() -> void:
	if money >= data["upgrade3"].cost:
		money -= data["upgrade3"].cost
		data["upgrade3"].cost = int(data["upgrade3"].cost * 1.5)
		data["upgrade3"].level += 1


func _on_reset_pressed() -> void:
	var config = ConfigFile.new()
	config.set_value("Main","money",0)
	config.set_value("Main","data",data)
	config.save(data_path)
	_load()


func _on_save_timer_timeout() -> void:
	print("Данные сохранены.")
	#_save()


func _on_save_pressed() -> void:
	_save()


func _on_load_pressed() -> void:
	_load()
