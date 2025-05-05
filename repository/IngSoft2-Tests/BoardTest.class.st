Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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
	self assert: aBoard size equals: 20
]

{ #category : 'tests' }
BoardTest >> testWhenNewBoardWithNSizeThenSizeIsN [

	| aBoard |
	aBoard := Board withSize: 30.
	self assert: aBoard size equals: 30
]
