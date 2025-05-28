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
BoardTest >> testBoardIsCreatedWithCorrectEffectProportions [
	| board tiles effectsCount |
	
	board := Board withRandomEffectsAndSize: 100 andWormholeFrom: 5 to: 15.
	tiles := board getTiles . 

	effectsCount := Dictionary new.
	
	tiles do: [ :tile |
		| effectClass |
		effectClass := tile getEffect class.
		effectsCount at: effectClass ifAbsentPut: [ 0 ].
		effectsCount at: effectClass put: (effectsCount at: effectClass) + 1.
	].

	self assert: (effectsCount at: NoEffect ) equals: 40.
	self assert: (effectsCount at: BlackHole ) equals: 20.
	self assert: (effectsCount at: HyperSpaceJump ) equals: 20.
	self assert: (effectsCount at: MoonWalk ) equals: 10.
	self assert: (effectsCount at: HyperJump ) equals: 8.
	self assert: (effectsCount at: AtomicBomb ) equals: 2.

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
	self assert: aSpaceship getLapsCompleted equals: 1
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
					addDice: (FixedDice onFace: 20);
		         build.

	aGame playRound.
	self assert: aSpaceship getLapsCompleted equals: 1
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
	self assert: aSpaceship getLapsCompleted equals: 2
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
	self assert: (aSpaceship getPosition )equals: 5.
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
