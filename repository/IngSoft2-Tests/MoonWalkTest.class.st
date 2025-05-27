Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MoonWalkTest >> testWhenSpaceshipLandsOnHyperSpaceJumpThenItIsMovedForward4PositionsAndLoosesAShield [

	| aSpaceship aSpaceship2 aGameBuilder finishLine aGame aCircularBoard |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	finishLine := 19.
	aCircularBoard := CircularBoard
		                  withSize: finishLine
		                  andWormholeFrom: 5
		                  to: 15.
	aCircularBoard add: (MoonWalk for:2) at: 4.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: aCircularBoard;
		         addDice: (FixedDice onFace: 4);
		         build.
	aGame playRound.

	self assert: (aSpaceship getPosition ) equals: 4.
	self assert: (aSpaceship2 getPosition ) equals: 17.
]
