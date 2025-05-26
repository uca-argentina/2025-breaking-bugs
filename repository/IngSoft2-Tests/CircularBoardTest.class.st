Class {
	#name : 'CircularBoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CircularBoardTest >> testLapsIncrementByOneAfterPassingBoardLimit [
	
	| aGameBuilder aSpaceship aGame aCircularBoard |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aCircularBoard := CircularBoard withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (aCircularBoard);
					addDice: (FixedDice onFace: 25);
		         build.

	aGame playRound2.
	self assert: aSpaceship lapsCompleted equals: 1
]

{ #category : 'tests' }
CircularBoardTest >> testLapsIncrementByOneAfterPassingBoardLimitwithTwoSpaceships [
	
	| aGameBuilder aSpaceship aGame aCircularBoard |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aCircularBoard := CircularBoard withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: Spaceship new;
		         addBoard: (aCircularBoard);
					addDice: (FixedDice onFace: 25);
		         build.

	aGame playRound2.
	self assert: aSpaceship lapsCompleted equals: 1
]

{ #category : 'tests' }
CircularBoardTest >> testLapsIncrementByTwoWhenPassingBoardTwice [
	
	| aGameBuilder aSpaceship aGame aCircularBoard |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aCircularBoard := CircularBoard withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (aCircularBoard);
					addDice: (FixedDice onFace: 41);
		         build.

	aGame playRound2.
	self assert: aSpaceship lapsCompleted equals: 2
]

{ #category : 'tests' }
CircularBoardTest >> testPositionResetsAfterPassingBoardLimit [
	
	| aGameBuilder aSpaceship aGame aCircularBoard |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aCircularBoard := CircularBoard withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (aCircularBoard);
					addDice: (FixedDice onFace: 25);
		         build.

	aGame playRound2.
	self assert: (aSpaceship isAtPosition: 5)
]
