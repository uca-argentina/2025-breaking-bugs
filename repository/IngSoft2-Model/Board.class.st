Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'aSize',
		'wormholes'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Board class >> checkSize: aSize [ 
	(aSize <= 0) ifTrue: [Error signal: 'The length of the board should be positive'].
]

{ #category : 'instance creation' }
Board class >> withSize: boardSize [
	self checkSize: boardSize.
	^ self new initializeWithSize: boardSize
]

{ #category : 'adding' }
Board >> addWormholeFrom: start to: destination [ 
	wormholes at: start put: destination.
	wormholes at: destination put: start.
	
]

{ #category : 'accessing' }
Board >> checkSize: numberToCheck [

	^ aSize = numberToCheck.
]

{ #category : 'initialization' }
Board >> initialize [

	| defaultSize |
	defaultSize := 20.
	
	wormholes := Dictionary new.

	aSize := defaultSize
]

{ #category : 'as yet unclassified' }
Board >> initializeWithSize: boardSize [

	aSize := boardSize.

	wormholes := Dictionary new
]

{ #category : 'as yet unclassified' }
Board >> positionAfterLandingOn: aPosition [

	^ wormholes at: aPosition
]
