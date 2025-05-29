Class {
	#name : 'HyperJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpTest >> testWhenSpaceshipsLandOnHyperSpaceJumpThenTheyAreMovedForwardAnAmountInParsecs [

	| aSpaceship aSpaceship2 aGameBuilder finishLine aGame aBoard aSpaceship3 |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	finishLine := 20.
	aBoard := Board withSize: finishLine andWormholeFrom: 5 to: 15.
	aBoard add: (HyperJump withDescendingParsecsFrom: 30 step: 10) at: 4.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addSpaceship: aSpaceship3;
		         addBoard: aBoard;
		         addDice: (FixedDice onFace: 4);
		         build.
	aGame playRound.

	self assert: aSpaceship getPosition equals: 19.
	self assert: aSpaceship2 getPosition equals: 14.
	self assert: aSpaceship3 getPosition equals: 9
]
