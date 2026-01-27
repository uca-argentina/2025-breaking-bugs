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
Board class >> validate: wormholeEntry and: wormholeExit within: aBoardDistance [
	
	((aBoardDistance lessThan: wormholeEntry) or: [ aBoardDistance lessThan: wormholeExit ]) ifTrue: [
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
    tiles := (1 to: aSize + 1) collect: [ :i | Tile with: NoEffect new ].
    ^ self 
        withSizeDistance: (Parsec with: aSize)
        andWormholeFrom: wormholeEntry
        to: wormholeExit
        and: tiles
]

{ #category : 'creation' }
Board class >> withSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit and: tiles [
    ^ self 
        withSizeDistance: (Parsec with: aSize)
        andWormholeFrom: wormholeEntry
        to: wormholeExit
        and: tiles   
]

{ #category : 'as yet unclassified' }
Board class >> withSizeDistance: aSizeDistance andWormholeFrom: wormholeEntry to: wormholeExit and: tiles [
    
    aSizeDistance validate.
    self validateAreNotNegative: wormholeEntry and: wormholeExit.
    self validate: wormholeEntry and: wormholeExit within: aSizeDistance.
    self validate: wormholeEntry notEqualTo: wormholeExit.
    self validate: wormholeEntry isLowerThan: wormholeExit.
    
    ^ self new
        initializeWith: tiles
        andSize: aSizeDistance
        andWormholeFrom: wormholeEntry
        to: wormholeExit
]

{ #category : 'as yet unclassified' }
Board class >> withSizeInLightYears: aSize andWormholeFrom: wormholeEntry to: wormholeExit [
    | tiles |
    tiles := (1 to: (aSize // 3) + 1) collect: [ :i | Tile with: NoEffect new ].
    
    ^ self 
        withSizeDistance: (LightYear with: aSize) 
        andWormholeFrom: wormholeEntry 
        to: wormholeExit 
        and: tiles
]

{ #category : 'as yet unclassified' }
Board class >> withSizeInLightYears: aSize andWormholeFrom: wormholeEntry to: wormholeExit and: tiles [
 	|  sizeInParsecs  |

    sizeInParsecs := aSize // 3.

	"entryInParsecs := wormholeEntry // 3.
    exitInParsecs := wormholeExit // 3. "
    ^ self 
        withSizeDistance: (LightYear with: aSize)
        andWormholeFrom: wormholeEntry   
        to: wormholeExit                   
        and: tiles
]

{ #category : 'initialization' }
Board >> applyTileEffectTo: aSpaceship in: aGame [

	| position tile |
	position := aSpaceship getPosition.
	tile := tiles at: (position+1).
	tile applyEffectTo: aSpaceship in: aGame
]

{ #category : 'as yet unclassified' }
Board >> checkSize: aDistanceToCompare [
	^ aSize checkIfEquals: aDistanceToCompare.
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
Board >> createPositionTable: spaceships [
	^ PositionTable with: spaceships.
]

{ #category : 'initialization' }
Board >> getSize [

	^ aSize.
]

{ #category : 'as yet unclassified' }
Board >> getTiles [
	^ tiles 
]

{ #category : 'testing' }
Board >> hasWormholeFrom: anEntry to: anExit [
    ^ (wormholeEntry = anEntry) 
        and: [ wormholeExit = anExit ]
	
]

{ #category : 'initialization' }
Board >> initializeWith: aTileCollection andSize: aDistanceSize andWormholeFrom: aWormholeEntry to: aWormholeExit [

	aSize := aDistanceSize.
	tiles := aTileCollection.
	wormholeEntry := aWormholeEntry.
	wormholeExit := aWormholeExit
]

{ #category : 'initialization' }
Board >> move: aSpaceship by: positionsToAdvance withLapLimit: lapLimit [
    aSpaceship moveBy: positionsToAdvance on: self withLapLimit: lapLimit.
]

{ #category : 'initialization' }
Board >> positionAfterMovingBack: positionsToGoBack for: aSpaceship [
	| boardSize currentPosition newPosition currentLap |

	boardSize := self getSize asParsec. 
	currentPosition := aSpaceship getPosition.
	currentLap := aSpaceship getLapsCompleted.

	newPosition := currentPosition - positionsToGoBack.

	newPosition < 0 ifTrue: [
		currentLap = 0 ifTrue: [ ^ 0 ].
		aSpaceship incrementLapsBy: -1.
		^ boardSize + newPosition
	].

	^ newPosition
]
