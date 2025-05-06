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
BoardTest >> testWhenNewBoardThenSizeIs20 [

	| aBoard |
	aBoard := Board new.
	self assert: (aBoard checkSize: 20).
]

{ #category : 'tests' }
BoardTest >> testWhenNewBoardWithNSizeThenSizeIsN [

	| aBoard nSize |
	nSize:= 30.
	aBoard := Board withSize: nSize.
	self assert: (aBoard checkSize: nSize).
]

{ #category : 'tests' }
BoardTest >> testWhenSizeIsNegativeThenTheCreationOfTheBoardFails [

	| nSize |
	nSize:= -30.
	self should: [Board withSize: nSize]
		  raise: Error
		  withMessageError: 'The length of the board should be positive'.
]
