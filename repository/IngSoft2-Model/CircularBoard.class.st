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

{ #category : 'testing' }
CircularBoard >> checkIfSpaceshipWon: aSpaceshipPosition [ 
	^ (aSpaceshipPosition > size)
]

{ #category : 'testing' }
CircularBoard >> correctPositionAfterWormholeIfNeeded: aSpaceshipPosition [
	
	^ board correctPositionAfterWormholeIfNeeded: aSpaceshipPosition.
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
