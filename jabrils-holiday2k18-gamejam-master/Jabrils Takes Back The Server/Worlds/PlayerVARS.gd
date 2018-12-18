extends Node2D

export var MULTI_JUMP = false
export var health = 100
export var hunger = 50

var remaining_jumps = 0
const UP = Vector2(0, -1)
const GRAVITY = 30
const ACCELERATION = 50
const MAX_SPEED = 250
const JUMP_HEIGHT = -600
const FRICTION_GROUND = 0.45
const FRICTION_AIR = 0.05
var motion = Vector2()