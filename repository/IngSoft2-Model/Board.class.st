Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'aSize',
		'wormholeEntry',
		'wormholeExit'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Board class >> validate: aSize [

	aSize <= 0 ifTrue: [
		Error signal: 'The length of the board should be positive' ]
]

{ #category : 'validation' }
Board class >> validate: wormholeEntry and: wormholeExit within: aBoardSize [

	(wormholeEntry > aBoardSize or: wormholeExit > aBoardSize) ifTrue: [
		Error signal: 'The wormhole cannot be outside of the board' ]
]

{ #category : 'validation' }
Board class >> validate: wormholeEntry isLowerThan: wormholeExit [

	wormholeEntry >= wormholeExit ifTrue: [
		Error signal:
			'Wormhole entry position value has to be lower than the exit position value' ]
]

{ #category : 'validation' }
Board class >> validate: wormholeEntry notEqualTo: wormholeExit [

	wormholeEntry = wormholeExit ifTrue: [
		Error signal:
			'The entry and the exit of the wormhole cannot be at the same position' ]
]

{ #category : 'validation' }
Board class >> validateIsNotNegative: wormholeEntry and: wormholeExit [ 

	wormholeEntry <= 0 ifTrue: [
		Error signal:
			'The wormhole cannot have negative entry' ]
]

{ #category : 'creation' }
Board class >> withSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit [

	self validate: aSize.
	
	self validateIsNotNegative: wormholeEntry and: wormholeExit.
	
	self validate: wormholeEntry and: wormholeExit within: aSize.

	self validate: wormholeEntry notEqualTo: wormholeExit.
	
	self validate: wormholeEntry isLowerThan: wormholeExit.


	^ self new
		  intializeWithSize: aSize
		  andWormholeFrom: wormholeEntry
		  to: wormholeExit
]

{ #category : 'testing' }
Board >> checkIfSpaceshipWon: aSpaceship [ 
	^ aSpaceship isAtPosition: aSize.
]

{ #category : 'testing' }
Board >> checkSize: size [

	^ aSize = size
]

{ #category : 'behavior' }
Board >> createPositionTable: aCollection [ 
	^ PositionTable with: aCollection andFinishLine: aSize.
]

{ #category : 'testing' }
Board >> hasWormholeFrom: aWormholeEntry to: aWormholeExit [

	^ wormholeEntry = aWormholeEntry and: wormholeExit = aWormholeExit
]

{ #category : 'initialization' }
Board >> intializeWithSize: size andWormholeFrom: aWormholeEntry to: aWormholeExit [

	aSize := size.
	wormholeEntry := aWormholeEntry.
	wormholeExit := aWormholeExit
]

{ #category : 'accessing' }
Board >> move: spaceships [

	spaceships do: [ :aSpaceship | aSpaceship moveUpTo: aSize ].

	self moveIfLandedOnWormhole: spaceships
]

{ #category : 'behavior' }
Board >> move: aSpaceship ifAt: position thenMoveTo: finalPosition [

	(aSpaceship isAtPosition: position) ifTrue: [
		aSpaceship moveToPosition: finalPosition. 
		^ true ].
	^ false.
]

{ #category : 'accessing' }
Board >> move: spaceships ifGameDidntFinish: aFlag [

	| gameHasFinished |
	gameHasFinished := aFlag.

	spaceships do: [ :aSpaceship |
		aSpaceship moveUpTo: aSize ifGameDidntFinish: gameHasFinished.
			gameHasFinished := self checkIfSpaceshipWon: aSpaceship  ].

	self moveIfLandedOnWormhole: spaceships.
]

{ #category : 'behavior' }
Board >> moveIfLandedOnWormhole: spaceships [

	| enteredWormhole |
	spaceships do: [ :aSpaceship |
		enteredWormhole := self
			                   move: aSpaceship
			                   ifAt: wormholeEntry
			                   thenMoveTo: wormholeExit.
		enteredWormhole ifFalse: [
			self move: aSpaceship ifAt: wormholeExit thenMoveTo: wormholeEntry ] ]
]

{ #category : 'behavior' }
Board >> verifyIfAnySpaceshipReachedFinishLine: spaceships [

	^ spaceships anySatisfy: [ :aSpaceship |
		  aSpaceship isAtPosition: aSize ]
]
