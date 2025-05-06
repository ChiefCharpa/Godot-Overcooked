extends Node
@export var Transitionpath: String;
@export var TransitionObj: String;
@export var holdPath: String;
@export var holdingStatusName: String;
@export var animationTree: AnimationTree;
@export var idleStateName: String;
@export var walkStateName: String;
@export var chopStateName: String;
@export var holdStateName: String;
@export var danceStateName: String;

var holding: bool;
var transition: AnimationNodeTransition;

func _ready():
	transition = animationTree.get(TransitionObj) as AnimationNodeTransition;
	

func _process(delta):
	pass


func _changeState(val: int):
	if (val == 1 and !holding):
		animationTree.set(Transitionpath, idleStateName);
	elif (val == 2 and !holding):
		animationTree.set(Transitionpath, walkStateName);
	elif (val == 3 and !holding):
		animationTree.set(Transitionpath, chopStateName);
	elif (val == 4 and !holding):
		animationTree.set(Transitionpath, holdStateName);
		holding = true;
	elif (val == 5 and !holding):
		animationTree.set(Transitionpath, danceStateName);


func _changeHolding():
	var hold = animationTree.get(holdPath) as AnimationNodeStateMachinePlayback;
	hold.travel(holdingStatusName);
	holding = false;
