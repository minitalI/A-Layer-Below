extends AnimatedSprite2D

# okay so im realizing that there needs to be something for bullets.
# it definitely needs to be a resource, right, because that makes it easy to store the like
# all the stats, damage, speed, and the sprite. maybe also like rotation, if thats not native
# but how do i store a sprite for a class?
# it can have the name of the sprite.
# but it has to be instantiating things; you cant just make a sprite without a node connected to it.
# unless you can instantiate a class with a sprite
# but more likely, you need to make a scene called bullet, with all of the afformentioned stats. 
# then things can inherit from the base bullet class, and add on effects and stuff. thats something.
# id like to have unique bullet types for each enemy, but the easiest way to do that by far would be 
# with a unique scene for each bullet type. put thats a lot of scenes.
# a scene for each bullet type, with each enemy probably having 1 - 3 unique bullets?
# this is kind of a hacky way to do things, but there could be just one scene, with every single bullet 
# type as a different sprite animation. 
# and then you just change the animation and resize the hitbox, change the stats. 
# that WOULD work. 
# could also have all of the sprites and hitboxes as nodes that are part of the scene, but enabled and disabled as needed.
# wait. thats what i was going to do anyways. make a node in each scene for the bullets.
# it would help to have a base bullet class tho.

# and now, make a probably animatedsprite2d scene with the bullet's sprite, named whatever, and then
# make a script that extends from bullet.gd, set the variables and any custom effects, and change the sprite as needed
# should be that simple.
# so there really doesn't need to be a unqiue scene for each, just a unique node. only needs a scene if 
# they're gonna be reused...... which actually some of them might be 
# and it would honestly be kinda annoying to just have some bullets who knows where, and others in 
# a folder. so maybe make a unqique scene for each, and then just put that into a folder so it doesn't get cluttered.

# that means we need a naming convention, ideally more informative than "abstracto bullet 1".
# i mean ig just call them the name of the og character + what they are?
# unless its just generic like circle. that can just be "circle bullet" and stuff
# so like "abstracto abstractoid"

# also how do we handle charge attacks. 
# it'll be in the code for the character.
# they'll have a different animation for charging.
# then it should be as easy as make them move faster and switch animation
# then the only issue is pathfinding, bleh.

# also make assets for these so i can just do the coding at school

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
