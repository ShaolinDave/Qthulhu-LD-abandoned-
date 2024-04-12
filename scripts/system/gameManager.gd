class_name GameManager
extends Node

static var player : CharacterBody2D
static var fire : StaticBody2D
static var tilemap : TileMap

static var qthulhuSpawner : Node
static var enemySpawners : Array[Node]
static var powerupSpawners : Array[Node]
static var currentLevel : int
static var currentScore : int
static var qthulhuTimer : float

var countDownRate = 0.1

const scoreTextFormat = "[right]%s[/right]"
@onready var scoreText : RichTextLabel = get_node("./Control/ScoreText")

func _ready():
	resetGame()
	
func resetGame():
	currentLevel = 0
	currentScore = 0
	qthulhuTimer = 100.0
	updateScoreText(currentScore)
	
func nextLevel():
	currentLevel += 1

func addToScore(points : int):
	currentScore += abs(points)
	updateScoreText(currentScore)

func qthulhuCountdown(amount : float):
	qthulhuTimer -= abs(amount)
	if qthulhuTimer <= 0.0 && qthulhuSpawner != null:
		qthulhuSpawner.spawnQuthulhu()

func updateScoreText(points : int):
	scoreText.text = scoreTextFormat % points
	
func _on_timer_timeout():
	qthulhuCountdown(countDownRate)
	countDownRate += 0.01
