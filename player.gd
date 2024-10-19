extends Area2D

@export var speed = 400 # how fast the player will move (pixels\sec)
var screen_size # Size of the game window

#Defined Signals of player
signal hit # deteccion de golpeo con el enemigo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#find size of the window
	screen_size = get_viewport_rect().size
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#(delta)-->longitud del fotograma - la cantidad de tiempo qque el fotograma anterior tardó en completarse. 
	#El parámetro delta en la función _process() se refiere a la longitud del fotograma - la cantidad de tiempo que
	#el fotograma anterior tardó en completarse. El uso de este valor asegura que su movimiento se mantendrá consistente incluso si la velocidad de fotogramas cambia.
	#get keys action 
	var velocity = Vector2.ZERO # movimiento del jugador
	
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

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		#Esta animacion debe ser volteada horizontalmente usando la propiedad flip_h para el movimiento hacia la izquierda
		#If true, texture is flipped=voltea  vertically.
		#Las asignaciones booleanas en el código anterior son una abreviatura común para los programadores. 
		#Dado que estamos haciendo una prueba de comparación (booleana) y también asignando un valor booleano, 
		#podemos hacer ambas cosas al mismo tiempo. Considere este código frente a la asignación booleana de una línea anterior:
		#if velocity.x < 0:
	      #$AnimatedSprite2D.flip_h = true
        #else:
	      #$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0 #velocodad menor a cero voltea la textura en la izquierda
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_v = velocity.y > 0 
	

func _on_body_entered(body:Node2D):
	#si esto pasa entonces el player desaparece
	hide()
	# Debe ser diferido ya que no podemos cambiar las propiedades físicas en un callback de física
	$CollisionShape2D.set_deferred("disabled", true)

func star(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false