extends Area2D

@export var speed = 400 # how fast the player will move (pixels\sec)
var screen_size # Size of the game window
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#find size of the window
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#(delta)-->longitud del fotograma - la cantidad de tiempo qque el fotograma anterior tardó en completarse. 
	#get keys action 
	var velocity = Vector2.ZERO #movimiento del jugador
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		# es la abreviatura de get_node() $AnimatedSprite2D.play() es lo mismo que get_node("AnimatedSprite2D").play().
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
    #También podemos utilizar clamp() para evitar que salga de la pantalla. Sujetar un valor significa restringirlo a un rango dado"
	position = position.clamp(Vector2.ZERO, screen_size)