Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MoonWalkTest >> testMoonWalkDoesNotMoveSpaceshipBelowStartWhenInFirstLap [

	| aSpaceship aSpaceship2 aSpaceship3 aGameBuilder finishLine aGame aBoard aTileBuilder aTileCollection getter |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	finishLine := 20.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder with: (MoonWalk for: 6) at: 4.
	aTileCollection := aTileBuilder build.
	aBoard := Board withSize: finishLine andWormholeFrom: 8 to: 15 and: aTileCollection.
	"aBoard add: (MoonWalk for: 6) at: 4."
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: aBoard;
		         addDice: (SequentialFixedDice onFaces: #( 2 4 ));
		         build.
	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship) equals: 0.
	self assert: (getter getPositionOf: aSpaceship2) equals: 4.
]

{ #category : 'tests' }
MoonWalkTest >> testWhenMoonWalkPushesSpaceshipBackPastZeroThenItWrapsToPreviousLap [

	| aSpaceship aSpaceship2 aSpaceship3 aGameBuilder finishLine aGame aBoard aTileBuilder aTileCollection getter |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	finishLine := 20.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder with: (MoonWalk for: 6) at: 4.
	aTileCollection := aTileBuilder build.
	aBoard := Board withSize: finishLine andWormholeFrom: 8 to: 15 and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: aBoard;
					setLapsToWinTo: 2;
		         addDice: (SequentialFixedDice onFaces: #( 25 24 ));
		         build.
	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship) equals: 19.
	self assert: (getter getPositionOf: aSpaceship2) equals: 4.
	self assert: (getter getLapsCompletedOf: aSpaceship) equals: 0.
	self assert: (getter getLapsCompletedOf: aSpaceship2) equals: 1.
	
]

{ #category : 'tests' }
MoonWalkTest >> testWhenSpaceshipLandsOnMoonWalkThenOtherSpaceshipMovesBack [

	| aSpaceship aSpaceship2 aGameBuilder finishLine aGame aBoard aTileBuilder aTileCollection getter |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	finishLine := 20.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder with: (MoonWalk for: 2) at: 6.
	aTileCollection := aTileBuilder build.
	aBoard := Board
		          withSize: finishLine
		          andWormholeFrom: 5
		          to: 15
		          and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: aBoard;
		         setLapsToWinTo: 2;
		         addDice: (SequentialFixedDice onFaces: #( 2 9 4 4 ));
		         build.
	aGame playRound.
	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship) equals: 6.
	self assert: (getter getPositionOf: aSpaceship2) equals: 11.
]
