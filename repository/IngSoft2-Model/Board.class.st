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
	  initializeWith:
	  ((1 to: aSize) collect: [ :i | Tile with: NoEffect new ])
	  andSize: aSize
	  andWormholeFrom: wormholeEntry
	  to: wormholeExit
]

{ #category : 'creation' }
Board class >> withSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit and: tiles [

	self validate: aSize.

	self validateAreNotNegative: wormholeEntry and: wormholeExit.

	self validate: wormholeEntry and: wormholeExit within: aSize.

	self validate: wormholeEntry notEqualTo: wormholeExit.

	self validate: wormholeEntry isLowerThan: wormholeExit.

	^ self new initializeWith: tiles andSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit. 
]

{ #category : 'initialization' }
Board >> applyTileEffectTo: aSpaceship in: aGame [

	| position tile |
	position := aSpaceship getPosition.
	tile := tiles at: (position+1).
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

	(aSpaceship hasReached: lapLimit) ifTrue: [ 
		^ aSize 
	].

	(aSpaceship getLapsCompleted = 0 and: [ newPosition < 0 ]) ifTrue: [
		^ 0
	].

	aSpaceship incrementLapsBy: lapsCompleted.
	^ newPosition

]

{ #category : 'behavior' }
Board >> createPositionTable: spaceships [

	^ PositionTable with: spaceships and: aSize
]

{ #category : 'initialization' }
Board >> getSize [

	^ aSize
]

{ #category : 'accessing' }
Board >> hasAtomicBombAt: aPosition [

	| tile |
	tile := tiles at: aPosition + 1.
	^ tile getEffect class = AtomicBomb
]

{ #category : 'testing' }
Board >> hasWormholeFrom: aWormholeEntry to: aWormholeExit [

	^ wormholeEntry = aWormholeEntry and: wormholeExit = aWormholeExit
]

{ #category : 'initialization' }
Board >> initializeWith: aTileCollection andSize:size andWormholeFrom: aWormholeEntry to: aWormholeExit [ 

	aSize := size.
	tiles := aTileCollection.
	wormholeEntry := aWormholeEntry.
	wormholeExit := aWormholeExit.
]
