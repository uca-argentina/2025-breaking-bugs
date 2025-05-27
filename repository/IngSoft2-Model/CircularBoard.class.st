Class {
	#name : 'CircularBoard',
	#superclass : 'Object',
	#instVars : [
		'board',
		'size',
		'tiles',
		'lapsToWin'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CircularBoard class >> withSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit [

	Board validateWith: wormholeEntry and: wormholeExit within: aSize.

	^ self new
		  intializeWithSize: aSize
		  andWormholeFrom: wormholeEntry
		  to: wormholeExit
]

{ #category : 'adding' }
CircularBoard >> add: anEffect at: aPosition [

	tiles at: aPosition put: (Tile with: anEffect)
]

{ #category : 'behavior' }
CircularBoard >> applyTileEffectTo: aSpaceship [

	| position tile |
	position := aSpaceship getPosition.
	tile := tiles at: position.
	tile applyEffectTo: aSpaceship
]

{ #category : 'testing' }
CircularBoard >> checkIfSpaceshipWon: aSpaceship [ 
	^ lapsToWin = aSpaceship lapsCompleted. 
]

{ #category : 'testing' }
CircularBoard >> correctPositionAfterWormholeIfNeeded: aSpaceshipPosition [
	
	^ board correctPositionAfterWormholeIfNeeded: aSpaceshipPosition.
]

{ #category : 'testing' }
CircularBoard >> correctPositionIf: aSpaceship passTheLine: aSpaceshipPosition [

	| lapsCompleted newPosition |
	lapsCompleted := aSpaceshipPosition // size.
	newPosition := aSpaceshipPosition \\ size.
	aSpaceship incrementLapsBy: lapsCompleted.

	^ newPosition "= 0
		  ifTrue: [ size ]
		  ifFalse: [ newPosition ]"
]

{ #category : 'testing' }
CircularBoard >> correctPositionIf: aSpaceship passTheLine: aSpaceshipPosition withLapLimit: lapLimit [
	"^ aSpaceshipPosition min: aSize."

	| lapsCompleted newPosition |
	lapsCompleted := aSpaceshipPosition // size.
	newPosition := aSpaceshipPosition \\ size.
	aSpaceship incrementLapsBy: lapsCompleted.

	aSpaceship lapsCompleted < lapLimit ifTrue: [ ^ newPosition ].

	^ size
]

{ #category : 'as yet unclassified' }
CircularBoard >> getSize [
	^ size 
]

{ #category : 'initialization' }
CircularBoard >> intializeWithSize: aSize andWormholeFrom: aWormholeEntry to: aWormholeExit [

	size := aSize.
	tiles := (1 to: size) collect: [ :i | Tile with: NoEffect new ].

	board := Board
		         withSize: size
		         andWormholeFrom: aWormholeEntry
		         to: aWormholeExit
]
