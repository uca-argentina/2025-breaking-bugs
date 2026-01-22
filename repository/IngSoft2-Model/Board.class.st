Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'aSize',
		'wormholeEntry',
		'wormholeExit',
		'tiles',
		'isInParcecs'
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

{ #category : 'creation' }
Board class >> withSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit [

	| tiles |
	self validate: aSize.

	self validateAreNotNegative: wormholeEntry and: wormholeExit.

	self validate: wormholeEntry and: wormholeExit within: aSize.

	self validate: wormholeEntry notEqualTo: wormholeExit.

	self validate: wormholeEntry isLowerThan: wormholeExit.
	tiles := (1 to: aSize + 1) collect: [ :i | Tile with: NoEffect new ].


	^ self
		  withSize: aSize
		  andWormholeFrom: wormholeEntry
		  to: wormholeExit
		  and: tiles
		  valueIsInParcecs: true
]

{ #category : 'creation' }
Board class >> withSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit and: tiles [

	self validate: aSize.

	self validateAreNotNegative: wormholeEntry and: wormholeExit.

	self validate: wormholeEntry and: wormholeExit within: aSize.

	self validate: wormholeEntry notEqualTo: wormholeExit.

	self validate: wormholeEntry isLowerThan: wormholeExit.

	^ self withSize: aSize andWormholeFrom: wormholeEntry  to: wormholeExit  and: tiles  valueIsInParcecs: true 
]

{ #category : 'creation' }
Board class >> withSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit and: tiles valueIsInParcecs: ifItIsInParcecs [

	self validate: aSize.

	self validateAreNotNegative: wormholeEntry and: wormholeExit.

	self validate: wormholeEntry and: wormholeExit within: aSize.

	self validate: wormholeEntry notEqualTo: wormholeExit.

	self validate: wormholeEntry isLowerThan: wormholeExit.

	^ self new initializeWith: tiles andSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit valueIsInParcecs: ifItIsInParcecs. 
]

{ #category : 'as yet unclassified' }
Board class >> withSizeInLightYears: aSize andWormholeFrom: wormholeEntry to: wormholeExit [

	| aSizeInParcecs wormholeEntryInParcecs wormholeExitInParcecs tiles |
	aSizeInParcecs := aSize // 3.
	wormholeEntryInParcecs := wormholeEntry // 3.
	wormholeExitInParcecs := wormholeExit // 3.
	tiles:= ((1 to: aSize + 1) collect: [ :i | Tile with: NoEffect new ]).
	
	^ self
		  withSize: aSizeInParcecs
		  andWormholeFrom: wormholeEntryInParcecs
		  to: wormholeExitInParcecs
		  and: tiles
		  valueIsInParcecs: false
]

{ #category : 'as yet unclassified' }
Board class >> withSizeInLightYears: aSize andWormholeFrom: wormholeEntry to: wormholeExit and: tiles [

	| aSizeInParcecs wormholeEntryInParcecs wormholeExitInParcecs |
	aSizeInParcecs := aSize // 3.
	wormholeEntryInParcecs := wormholeEntry // 3.
	wormholeExitInParcecs := wormholeExit // 3.
	^ self
		  withSize: aSizeInParcecs
		  andWormholeFrom: wormholeEntryInParcecs
		  to: wormholeExitInParcecs
		  and: tiles
		  valueIsInParcecs: false
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
	(isInParcecs) ifTrue: [ ^ aSize = size ].
	^ aSize = (size // 3)
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
	| lapsCompleted newPosition totalLaps |

	lapsCompleted := aSpaceshipPosition // aSize.
	newPosition := aSpaceshipPosition \\ aSize.

	aSpaceship incrementLapsBy: lapsCompleted.
	totalLaps := aSpaceship getLapsCompleted.

	"Si justo alcanza la meta, devolver finishLine"
	(totalLaps >= lapLimit ) ifTrue: [
		^ aSize
	].

	^ newPosition


]

{ #category : 'behavior' }
Board >> createPositionTable: spaceships [

	^ PositionTable with: spaceships and: aSize
]

{ #category : 'initialization' }
Board >> getSize [
	(isInParcecs) ifTrue: [ ^ aSize  ].

	^ aSize *3
]

{ #category : 'as yet unclassified' }
Board >> getTiles [
	^ tiles 
]

{ #category : 'testing' }
Board >> hasWormholeFrom: aWormholeEntry to: aWormholeExit [
	(isInParcecs) ifTrue: [ ^ wormholeEntry = aWormholeEntry and: wormholeExit = aWormholeExit ].

	^ wormholeEntry = (aWormholeEntry //3) and: wormholeExit = (aWormholeExit //3)
]

{ #category : 'initialization' }
Board >> initializeWith: aTileCollection andSize:size andWormholeFrom: aWormholeEntry to: aWormholeExit valueIsInParcecs: ifItIsInParcecs [

	aSize := size.
	tiles := aTileCollection.
	wormholeEntry := aWormholeEntry.
	wormholeExit := aWormholeExit.
	isInParcecs := ifItIsInParcecs 
]
