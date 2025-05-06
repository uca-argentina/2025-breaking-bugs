Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'aSize',
		'wormholes',
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

{ #category : 'as yet unclassified' }
Board class >> validate: wormholeEntry and: wormholeExit within: aBoardSize [

	(wormholeEntry > aBoardSize or: wormholeExit > aBoardSize) ifTrue: [
		Error signal: 'The wormhole cannot be outside of the board' ]
]

{ #category : 'as yet unclassified' }
Board class >> validate: wormholeEntry notEqualTo: wormholeExit [

	wormholeEntry = wormholeExit ifTrue: [
		Error signal:
			'The entry and the exit of the wormhole cannot be at the same position' ]
]

{ #category : 'instance creation' }
Board class >> withSize: boardSize [
	self validate: boardSize.
	^ self new initializeWithSize: boardSize
]

{ #category : 'as yet unclassified' }
Board class >> withSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit [

	self validate: aSize.

	self validate: wormholeEntry and: wormholeExit within: aSize.

	self validate: wormholeEntry notEqualTo: wormholeExit.


	^ self new
		  intializeWithSize: aSize
		  andWormholeFrom: wormholeEntry
		  to: wormholeExit
]

{ #category : 'adding' }
Board >> addWormholeFrom: start to: destination [ 
	wormholes at: start put: destination.
	wormholes at: destination put: start.
	
]

{ #category : 'as yet unclassified' }
Board >> checkSize: size [

	^ aSize = size
]

{ #category : 'testing' }
Board >> hasWormholeFrom: aWormholeEntry to: aWormholeExit [

	^ wormholeEntry = aWormholeEntry and: wormholeExit = aWormholeExit
]

{ #category : 'as yet unclassified' }
Board >> initializeWithSize: boardSize [

	aSize := boardSize.

	wormholes := Dictionary new
]

{ #category : 'as yet unclassified' }
Board >> intializeWithSize: size andWormholeFrom: aWormholeEntry to: aWormholeExit [

	aSize := size.
	wormholeEntry := aWormholeEntry.
	wormholeExit := aWormholeExit
]

{ #category : 'as yet unclassified' }
Board >> positionAfterLandingOn: aPosition [

	^ wormholes at: aPosition
]
