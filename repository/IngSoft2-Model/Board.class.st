Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'aSize',
		'wormholeEntry',
		'wormholeExit',
		'tiles'
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
Board class >> validateAreNotNegative: wormholeEntry and: wormholeExit [

	(wormholeEntry <= 0 or: wormholeExit <= 0) ifTrue: [
		Error signal: 'The wormhole cannot have negative entry or exit' ]
]

{ #category : 'validation' }
Board class >> validateWith: wormholeEntry and: wormholeExit within: aSize [
	self validate: aSize.

	self validateAreNotNegative: wormholeEntry and: wormholeExit.

	self validate: wormholeEntry and: wormholeExit within: aSize.

	self validate: wormholeEntry notEqualTo: wormholeExit.

	self validate: wormholeEntry isLowerThan: wormholeExit.
]

{ #category : 'creation' }
Board class >> withSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit [

	self validate: aSize.

	self validateAreNotNegative: wormholeEntry and: wormholeExit.

	self validate: wormholeEntry and: wormholeExit within: aSize.

	self validate: wormholeEntry notEqualTo: wormholeExit.

	self validate: wormholeEntry isLowerThan: wormholeExit.


	^ self new
		  intializeWithSize: aSize
		  andWormholeFrom: wormholeEntry
		  to: wormholeExit
]

{ #category : 'initialization' }
Board >> add: anEffect at: aPosition [

	tiles at: aPosition put: (Tile with: anEffect)
]

{ #category : 'initialization' }
Board >> applyTileEffectTo: aSpaceship in: aGame [

	| position tile |
	position := aSpaceship getPosition.
	tile := tiles at: position.
	tile applyEffectTo: aSpaceship in: aGame
]

{ #category : 'testing' }
Board >> checkSize: size [

	^ aSize = size
]

{ #category : 'testing' }
Board >> correctPositionAfterWormholeIfNeeded: aSpaceshipPosition [

	^ aSpaceshipPosition = wormholeEntry
		  ifTrue: [ wormholeExit ]
		  ifFalse: [
			  aSpaceshipPosition = wormholeExit
				  ifTrue: [ wormholeEntry ]
				  ifFalse: [ aSpaceshipPosition ] ]
]

{ #category : 'behavior' }
Board >> correctPositionIf: aSpaceship passTheLine: aSpaceshipPosition withLapLimit: lapLimit [

	| lapsCompleted newPosition |
	lapsCompleted := aSpaceshipPosition // aSize.
	newPosition := aSpaceshipPosition \\ aSize.
	aSpaceship incrementLapsBy: lapsCompleted.

	aSpaceship lapsCompleted < lapLimit ifTrue: [ ^ newPosition ].

	^ aSize
]

{ #category : 'behavior' }
Board >> createPositionTable: spaceships [

	^ PositionTable with: spaceships and: aSize
]

{ #category : 'initialization' }
Board >> getSize [

	^ aSize
]

{ #category : 'testing' }
Board >> hasWormholeFrom: aWormholeEntry to: aWormholeExit [

	^ wormholeEntry = aWormholeEntry and: wormholeExit = aWormholeExit
]

{ #category : 'initialization' }
Board >> intializeWithSize: size andWormholeFrom: aWormholeEntry to: aWormholeExit [

	aSize := size.
	tiles := (1 to: size) collect: [ :i | Tile with: NoEffect new ].
	wormholeEntry := aWormholeEntry.
	wormholeExit := aWormholeExit
]
