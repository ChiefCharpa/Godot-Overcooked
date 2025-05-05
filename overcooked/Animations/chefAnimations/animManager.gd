extends Node
@export var Transitionpath: String;
@export var holdPath: String;
@export var holdingStatusName: String;
@export var animationTree: AnimationTree;
@export var idleStateName: String;
@export var walkStateName: String;
@export var chopStateName: String;
@export var holdStateName: String;
@export var danceStateName: String;

var holding: bool;


func _ready():
	pass
	

func _process(delta):
	pass


func _changeState(val: int):
	var transition = animationTree.get(Transitionpath) as AnimationNodeTransition;
	if (val == 1):
		animationTree.set(transition, idleStateName);
	elif (val == 2):
		animationTree.set(transition, walkStateName);
	elif (val == 3):
		animationTree.set(transition, chopStateName);
	elif (val == 4):
		animationTree.set(transition, holdStateName);
	else:
		animationTree.set(transition, danceStateName);


func changeHolding():
	var hold = animationTree.get(holdPath) as AnimationNodeStateMachinePlayback;
	hold.travel(holdingStatusName);
