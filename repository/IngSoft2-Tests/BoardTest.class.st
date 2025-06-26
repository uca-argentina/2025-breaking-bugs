Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BoardTest >> should: test raise: aErrorClass withMessageError: aMessage [ 
	self 
		should: test
		raise: aErrorClass 
		withExceptionDo:  [: error | self assert: (error messageText) equals: aMessage].
]

{ #category : 'tests' }
BoardTest >> testBoardCreationFailsWhenWormholeEntryValueIsHigherThanExitValue [

	| aSize |
	aSize := 20.

	self
		should: [ Board withSize: aSize andWormholeFrom: 15 to: 12 ]
		raise: Error
		withMessageError: 'Wormhole entry position value has to be lower than the exit position value'
]

{ #category : 'tests' }
BoardTest >> testCreatingABoardWithSize20AndWormholeFrom4To9 [

	| aBoard aSize |
	aSize := 20.
	aBoard := Board withSize: aSize andWormholeFrom: 4 to: 9.
	self assert: (aBoard checkSize: aSize).
	self assert: (aBoard hasWormholeFrom: 4 to: 9)
]

{ #category : 'tests' }
BoardTest >> testCreatingABoardWithSizeInLightYearsAndWormhole [

	| aBoard aSize |
	aSize := 60.
	aBoard := Board withSizeInLightYears: aSize andWormholeFrom: 12 to: 27.
	self assert: (aBoard checkSize: aSize ).
	self assert: (aBoard hasWormholeFrom: 12 to: 27)
]

{ #category : 'tests' }
BoardTest >> testCreatingABoardWithSizeInLightYearsAndWormholeAndTiles [
	
	| game aSpaceship1  board gameBuilder finishLine tileBuilder tileCollection |

	gameBuilder := GameBuilder new.
	aSpaceship1 := Spaceship new. 
	finishLine := 75.

	tileBuilder := TilesBuilder withInLightYears: finishLine.
	tileBuilder
		with: AtomicBomb new at: 9;
		with: BlackHole new at: 27;
		with: (HyperJump withDescendingParsecsFrom: 90 step: 30) at: 30;
		with: (MoonWalk for: 6) at: 57;
		with: HyperSpaceJump new at: 48.

	tileCollection := tileBuilder build.

	board := Board withSizeInLightYears: finishLine andWormholeFrom: 12 to: 45 and: tileCollection.

	game := gameBuilder
		addSpaceship: aSpaceship1; 
		addBoard: board;
		addDice: (SequentialFixedDice onFaces: #(9 27 15 12 30 33 42 12));
		setLapsToWinTo: 2;
		build.
		
	self assert: (board checkSize: finishLine).
	self assert: (board hasWormholeFrom: 12 to: 45).
	self assert: (board getTiles) equals: tileCollection .
]

{ #category : 'tests' }
BoardTest >> testLapsIncrementByOneAfterPassingBoardLimit [

	| aGameBuilder aSpaceship aGame |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 25);
		         setLapsToWinTo: 2;
		         build.

	aGame playRound.
	self assert: (aGame getLapsCompletedOf: aSpaceship) equals: 1.
	
]

{ #category : 'tests' }
BoardTest >> testLapsIncrementByOneAfterPassingBoardLimitwithTwoSpaceships [
	
	| aGameBuilder aSpaceship aGame |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: Spaceship new;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: 22); "Si es 20 da error"
		         build.

	aGame playRound.
	self assert: (aGame getLapsCompletedOf: aSpaceship) equals: 1.
]

{ #category : 'tests' }
BoardTest >> testLapsIncrementByTwoWhenPassingBoardTwice [
	
	| aGameBuilder aSpaceship aGame |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: 40);
					setLapsToWinTo: 3;
		         build.

	aGame playRound.
	self assert: (aGame getLapsCompletedOf: aSpaceship) equals: 2.
]

{ #category : 'tests' }
BoardTest >> testPositionResetsAfterPassingBoardLimit [
	
	| aGameBuilder aSpaceship aGame  |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: 25);
					setLapsToWinTo: 2;
		         build.

	aGame playRound.
	self assert: (aGame getPositionOf: aSpaceship) equals: 5.
]

{ #category : 'tests' }
BoardTest >> testWhenCreatingABoardWithSize20ThenSizeIs20 [

	| aBoard aSize |
	aSize := 20.
	aBoard := Board withSize: aSize andWormholeFrom: 4 to: 9.
	self assert: (aBoard checkSize: aSize)
]

{ #category : 'tests' }
BoardTest >> testWhenSizeIsNegativeThenTheCreationOfTheBoardFails [

	| aSize |
	aSize:= -30.
	self should: [Board withSize: aSize andWormholeFrom: 4 to: 9]
		  raise: Error
		  withMessageError: 'The length of the board should be positive'.
]

{ #category : 'tests' }
BoardTest >> testWhenTryingToCreateABoardWithAWormholeWithSameEntryAndExitThenCreationFails [

	| aSize |
	aSize := 20.

	self
		should: [ Board withSize: aSize andWormholeFrom: 15 to: 15 ]
		raise: Error
		withMessageError: 'The entry and the exit of the wormhole cannot be at the same position'
]

{ #category : 'tests' }
BoardTest >> testWhenTryingToCreateAWormholeOutsideTheBoardThenCreationFails [

	| aSize |
	aSize := 20.

	self
		should: [ Board withSize: aSize andWormholeFrom: 15 to: 21 ]
		raise: Error
		withMessageError: 'The wormhole cannot be outside of the board'
]

{ #category : 'tests' }
BoardTest >> testWhenTryingToCreateAWormholeWithNegativeEntryThenCreationFails [

	| aSize |
	aSize := 20.

	self
		should: [ Board withSize: aSize andWormholeFrom: -5 to: 4 ]
		raise: Error
		withMessageError: 'The wormhole cannot have negative entry or exit'. 
]
