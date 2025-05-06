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
BoardTest >> testBoardHasWormholes [

	| board |
	board := Board withSize: 20.
	board addWormholeFrom: 2 to: 15.
	self assert: (board positionAfterLandingOn: 2) equals: 15.
	self assert: (board positionAfterLandingOn: 15) equals: 2.
	
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
BoardTest >> testWhenCreatingABoardWithSize20ThenSizeIs20 [

	| aBoard aSize |
	aSize := 20.
	aBoard := Board withSize: aSize.
	self assert: (aBoard checkSize: aSize)
]

{ #category : 'tests' }
BoardTest >> testWhenSizeIsNegativeThenTheCreationOfTheBoardFails [

	| aSize |
	aSize:= -30.
	self should: [Board withSize: aSize]
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
