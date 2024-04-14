class_name WinTable extends Resource

enum Result {
	W = 2,
	L = 0,
	T = 1,
}

@export var table: Array[Array] = [
	[Result.T, Result.L, Result.L, Result.T, Result.T, Result.L, Result.W, Result.T, Result.W, Result.W], # POISON
	[Result.W, Result.T, Result.L, Result.W, Result.T, Result.W, Result.T, Result.L, Result.L, Result.W], # FIRE
	[Result.W, Result.W, Result.T, Result.L, Result.L, Result.L, Result.W, Result.T, Result.W, Result.L], # WATER
	[Result.T, Result.L, Result.W, Result.T, Result.T, Result.T, Result.L, Result.W, Result.L, Result.W], # ICE
	[Result.T, Result.T, Result.W, Result.T, Result.T, Result.W, Result.T, Result.L, Result.L, Result.T], # LIGHTNING
	[Result.W, Result.L, Result.W, Result.T, Result.L, Result.T, Result.L, Result.T, Result.T, Result.W], # DARK
	[Result.L, Result.T, Result.L, Result.W, Result.T, Result.W, Result.T, Result.T, Result.T, Result.T], # LIGHT
	[Result.T, Result.W, Result.T, Result.L, Result.W, Result.T, Result.T, Result.T, Result.W, Result.L], # WIND
	[Result.L, Result.W, Result.L, Result.W, Result.W, Result.T, Result.T, Result.L, Result.T, Result.L], # ROCK
	[Result.L, Result.L, Result.W, Result.L, Result.T, Result.L, Result.T, Result.W, Result.W, Result.T], # NATURE
]
