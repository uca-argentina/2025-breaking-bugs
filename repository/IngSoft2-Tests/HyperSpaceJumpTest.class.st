Class {
	#name : 'HyperSpaceJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperSpaceJumpTest >> testWhenSpaceshipLandsOnHyperSpaceJumpThenItIsMovedForward4PositionsAndLoosesAShield [

	| aSpaceship aGameBuilder finishLine aGame aBoard aTileBuilder aTileCollection |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	finishLine := 19.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder with: HyperSpaceJumpEffect new at: 4.
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
	self assert: (aGame getPositionOf: aSpaceship) equals: 8.
	self assert: (aGame getShieldsOf: aSpaceship) equals: 2.
	
]
