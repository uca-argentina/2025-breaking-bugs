Class {
	#name : 'HyperJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpTest >> testWhenSpaceshipsLandOnHyperSpaceJumpThenTheyAreMovedForwardAnAmountInLightYears [

	| aSpaceship aSpaceship2 aGameBuilder finishLine aGame aBoard aSpaceship3 aTileBuilder aTileCollection |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	finishLine := 20.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder
		with: (HyperJumpEffect withDescendingLightYearsFrom: 90 step: 30)
		at: 4.
	aTileCollection := aTileBuilder build.
	aBoard := Board
		          withSize: finishLine
		          andWormholeFrom: 5
		          to: 15
		          and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addSpaceship: aSpaceship3;
		         addBoard: aBoard;
		         addDice: (FixedDice onFace: 4);
		         build.
	aGame playRound.

	self assert: (aGame spaceshipMatching: aSpaceship) getPosition equals: 19.
	self assert: (aGame spaceshipMatching: aSpaceship2) getPosition equals: 14.
	self assert: (aGame spaceshipMatching: aSpaceship3) getPosition equals: 9.
]

{ #category : 'tests' }
HyperJumpTest >> testWhenSpaceshipsLandOnHyperSpaceJumpThenTheyAreMovedForwardAnAmountInParsecs [

	| aSpaceship aSpaceship2 aGameBuilder finishLine aGame aBoard aSpaceship3 aTileBuilder aTileCollection |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	finishLine := 20.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder
		with: (HyperJumpEffect withDescendingParsecsFrom: 30 step: 10)
		at: 4.
	aTileCollection := aTileBuilder build.
	aBoard := Board
		          withSize: finishLine
		          andWormholeFrom: 5
		          to: 15
		          and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addSpaceship: aSpaceship3;
		         addBoard: aBoard;
		         addDice: (FixedDice onFace: 4);
		         build.
	aGame playRound.

	self assert: (aGame spaceshipMatching: aSpaceship) getPosition equals: 19.
	self assert: (aGame spaceshipMatching: aSpaceship2) getPosition equals: 14.
	self assert: (aGame spaceshipMatching: aSpaceship3) getPosition equals: 9.
]
