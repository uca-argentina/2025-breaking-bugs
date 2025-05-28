Class {
	#name : 'HyperJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpTest >> testWhenSpaceshipLandsOnHyperSpaceJumpThenItIsMovedForward4PositionsAndLoosesAShield [

	| aSpaceship aSpaceship2 aGameBuilder finishLine aGame aBoard |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	finishLine := 20.
	aBoard := Board withSize: finishLine andWormholeFrom: 5 to: 15.
	aBoard add: HyperJump new at: 4.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: aBoard;
		         addDice: (FixedDice onFace: 4);
		         build.
	aGame playRound.

	self assert: aSpaceship getPosition equals: 9.
	self assert: aSpaceship2 getPosition equals: 14
]
