extends RigidBody3D

var resource_type = "Interactable"
var recipeTexture
var inventory_node
var currentCounter
var cookedDish
var recipes: Array = [["Soup_Tomato"], ["Soup_Onion"], ["Soup_Mushroom"],["Burger"],["Burger+Lettuce"],["Burger+Lettuce+Tomato"],["Chopped_Lettuce"],["Salad+Tomato"]]
var orders: Array = []
var plateSpawnNode

@onready var scoreNode = get_node("/root/LevelNode/UI/StatDisplay/Score")
@onready var recipe_display: Control = get_node("/root/LevelNode/UI/RecipeDisplay")
@onready var order_Timer = $place_Order_Timer

func _ready():
	plateSpawnNode = get_node("/root/LevelNode/Service_Counter/Counter_Rigidbody")
	currentCounter = self
	_on_place_order_timer_timeout()

func start_random_timer():
	var new_time = randf_range(10.0, 20.0)
	print(new_time)
	order_Timer.wait_time = new_time
	order_Timer.start()
	
func _on_place_order_timer_timeout() -> void:
	print("hiodw")
	var random_number = randi_range(0, 5)
	var new_order = {
		"recipe": recipes[random_number],
		"time_added": Time.get_ticks_msec() / 1000.0  # Convert to seconds
	}
	displayOrder(new_order)
	orders.append(new_order)
	print("new order", new_order)
	start_random_timer()

func _process(delta):
	var current_time = Time.get_ticks_msec() / 1000.0
	for i in range(orders.size() - 1, -1, -1):
		if current_time - orders[i].time_added >= 20.0:
			print("Order expired:", orders[i].recipe)
			recipe_display.destroyRecipe()
			orders.remove_at(i)
			scoreNode.addScore(-5)  # Penalty


func _activate(inventory_node):
	if inventory_node:
		if inventory_node.resources_inventory.size() > 0:
			if inventory_node.heldVegetable and inventory_node.heldVegetable.has_method("cleanPlate"):
				cookedDish = inventory_node.heldVegetable
				inventory_node._place_item(currentCounter.get_path())

				var held_vegetable_names = []
				for item in cookedDish.held_vegetables:
					held_vegetable_names.append(str(item))
				held_vegetable_names.sort()

				for i in range(orders.size() - 1, -1, -1):
					var recipe = orders[i].recipe
					var sorted_recipe = recipe.duplicate()
					sorted_recipe.sort()

					if held_vegetable_names == sorted_recipe:
						cookedDish.queue_free()
						orders.remove_at(i)
						plateSpawnNode.call("spawn")
						print("Order completed and removed:", recipe)
						scoreNode.addScore(10)
						return
					else:
						print("Order doesn't match:", recipe)
			else:
				print("Held vegetable is invalid or has no cleanPlate method")
		else:
			print("Inventory is empty")
	else:
		print("Player node is not set")

func get_some_variable():
	return resource_type

# Displays orders at top of screen
func displayOrder(order):
	if order["recipe"][0] == "Soup_Tomato":
		recipeTexture = load("res://UI/Recipes/Soups/Recipe_Soup_TomatoSoup.png")
		recipe_display.displayRecipe(recipeTexture)
	if order["recipe"][0] == "Soup_Mushroom":
		recipeTexture = load("res://UI/Recipes/Soups/Recipe_Soup_MushroomSoup.png")
		recipe_display.displayRecipe(recipeTexture)
	if order["recipe"][0] == "Soup_Onion":
		recipeTexture = load("res://UI/Recipes/Soups/Recipe_Soup_OnionSoup.png")
		recipe_display.displayRecipe(recipeTexture)

	if order["recipe"][0] == "Burger":
		recipeTexture = load("res://UI/Recipes/Burgers/Recipe_Burger_2.png")
		recipe_display.displayRecipe(recipeTexture)
	if order["recipe"][0] == "Burger+Lettuce":
		recipeTexture = load("res://UI/Recipes/Burgers/Recipe_Burger_3.png")
		recipe_display.displayRecipe(recipeTexture)
	if order["recipe"][0] == "Burger+Lettuce+Tomato":
		recipeTexture = load("res://UI/Recipes/Burgers/Recipe_Burger_4.png")
		recipe_display.displayRecipe(recipeTexture)
