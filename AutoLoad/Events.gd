extends Node

# Signal that is fired when the player gets some points
signal PlayerScored(points: int)


# Something collided with the death plane
signal DeathPlaneHit(deathPlane: Node, object: Node)


# Player has died
signal PlayerDied()
