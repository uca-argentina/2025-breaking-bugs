Class {
	#name : 'BlackHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BlackHoleTest >> testWhenSpaceshipLandsOnBlackHoleItMovesBack4PositionsWithoutTriggeringBattle [

	| aSpaceship aGameBuilder finishLine aGame aBoard aTileBuilder aTileCollection |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	finishLine := 19.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder with: (BlackHole new) at: 9.
	aTileBuilder with: (BlackHole new) at: 13.
	aTileCollection := aTileBuilder build.
	aBoard := Board withSize: finishLine andWormholeFrom: 10 to: 15 and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: Spaceship new;
		         addSpaceship: aSpaceship;
		         addBoard: aBoard;
		         addDice: (SequentialFixedDice onFaces: #( 13 9 ));
		         build.
	aGame playRound.

	self assert: (aGame getPositionOf: aSpaceship) equals: 5.
]

{ #category : 'tests' }
BlackHoleTest >> testWhenSpaceshipLandsOnBlackHoleThenItIsMovedBack4Positions [

	| aSpaceship aGameBuilder finishLine aGame aBoard aTileCollection aTileBuilder |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	
	finishLine := 19.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder with: (BlackHole new) at: 4.
	aTileCollection := aTileBuilder build.
	aBoard := (Board withSize: finishLine andWormholeFrom: 5 to: 15 and: aTileCollection).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
			      addBoard: aBoard;   
		         addDice: (FixedDice onFace: 4);
		         build.
	aGame playRound.
	
	self assert: (aSpaceship isAtPosition:0).

]
