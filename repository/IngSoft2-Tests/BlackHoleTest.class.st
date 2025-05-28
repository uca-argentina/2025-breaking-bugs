Class {
	#name : 'BlackHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BlackHoleTest >> testWhenSpaceshipLandsOnBlackHoleItMovesBack4PositionsWithoutTriggeringBattle [

	| aSpaceship aGameBuilder finishLine aGame aBoard|
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	finishLine := 19.
	aBoard := (Board withSize: finishLine andWormholeFrom: 5 to: 15).
	aBoard add: BlackHole new at: 9.
	aBoard add: BlackHole new at: 13.
	aGame := aGameBuilder
					addSpaceship: Spaceship new;
		         addSpaceship: aSpaceship;
			      addBoard: aBoard;   
		         addDice: (SequentialFixedDice onFaces: #(13 9));
		         build.
	aGame playRound.
	
	self assert: (aSpaceship getPosition) equals: 5.

]

{ #category : 'tests' }
BlackHoleTest >> testWhenSpaceshipLandsOnBlackHoleThenItIsMovedBack4Positions [

	| aSpaceship aGameBuilder finishLine aGame aBoard|
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	finishLine := 19.
	aBoard := (Board withSize: finishLine andWormholeFrom: 5 to: 15).
	aBoard add: BlackHole new at: 4.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
			      addBoard: aBoard;   
		         addDice: (FixedDice onFace: 4);
		         build.
	aGame playRound.
	
	self assert: (aSpaceship isAtPosition:0).

]
