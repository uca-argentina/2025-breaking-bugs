Class {
	#name : 'HyperSpaceJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperSpaceJumpTest >> testWhenSpaceshipLandsOnHyperSpaceJumpThenItIsMovedForward4PositionsAndLoosesAShield [

	| aSpaceship aGameBuilder finishLine aGame aBoard aTileBuilder aTileCollection getter|
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	finishLine := 19.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder with: HyperSpaceJump new at: 4.
	aTileCollection := aTileBuilder build.
	aBoard := Board
		          withSize: finishLine
		          andWormholeFrom: 5
		          to: 15
		          and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: aBoard;
		         addDice: (FixedDice onFace: 4);
		         build.
	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship) equals: 8.
	self assert: (getter getShieldsOf: aSpaceship) equals: 2.
	
]
