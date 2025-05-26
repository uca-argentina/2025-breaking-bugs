Class {
	#name : 'CircularBoard',
	#superclass : 'Object',
	#instVars : [
		'board',
		'size'
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

{ #category : 'testing' }
CircularBoard >> checkIfSpaceshipWon: aSpaceshipPosition [ 
	^ false.
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
    ^ newPosition = 0 ifTrue: [size] ifFalse: [newPosition].

]

{ #category : 'testing' }
CircularBoard >> correctPositionIfPassTheLine: aSpaceshipPosition [
    (aSpaceshipPosition > size) ifTrue: [ ^ aSpaceshipPosition - size ]
]

{ #category : 'initialization' }
CircularBoard >> intializeWithSize: aSize andWormholeFrom: aWormholeEntry to: aWormholeExit [
	size := aSize.
	board := Board withSize: size andWormholeFrom: aWormholeEntry to: aWormholeExit.
]
