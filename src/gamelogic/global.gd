#This script is a way to communicate various important variables between scripts, it is therefore auto-loaded

extends Node

var rawSeed
var _realWorldSize
var _realStartPos
var coordinateStart: = Vector2(0,0)
var coordinateEnd: = Vector2(0,0)
var terrainArray = []
var playerInventoryStone = 0
var minYvalue
var biomes = ["Alien1", "Desert1"]
var worlds = []
var wantedWorld


