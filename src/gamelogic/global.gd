#This script is a way to communicate various important variables between scripts, it is therefore auto-loaded

extends Node

var rawSeed
var _realWorldSize
var _realStartPos
var coordinateStart: = Vector2(0,0)
var coordinateEnd: = Vector2(0,0)
var terrainArray = []
var minYvalue
var maxYvalue
var biomes = ["Alien1", "Desert1", "Jungle1"]
var worlds = []
var wantedWorld = []
var playerPos = Vector2(20, 200)
var isInShip
var systemName 
var maxWorldSize = 200
var showFPS = false


