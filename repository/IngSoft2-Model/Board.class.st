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

{ #category : 'instance creation' }
Board class >> withSize: boardSize [

	^ self new initializeWithSize: boardSize
]

{ #category : 'adding' }
Board >> addWormholeFrom: start to: destination [ 
	wormholes at: start put: destination.
	wormholes at: destination put: start.
	
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

{ #category : 'accessing' }
Board >> size [

	^ aSize.
]
