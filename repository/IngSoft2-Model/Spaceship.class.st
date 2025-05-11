Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'dice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Spaceship class >> with: dice [

	^ self new initializeWith: dice
]

{ #category : 'initialization' }
Spaceship >> initialize [

	position := 0
]

{ #category : 'initialization' }
Spaceship >> initializeWith: aCollectionOfDice [

	dice := aCollectionOfDice
]

{ #category : 'testing' }
Spaceship >> isAtPosition: aPosition [

	^ position = aPosition
]

{ #category : 'move' }
Spaceship >> move [

	| positionsToAdvance newPosition |
	positionsToAdvance := dice
		                      inject: 0
		                      into: [ :totalPositions :aDice |
		                      totalPositions + aDice roll ].
	newPosition := position + positionsToAdvance.
	self moveToPosition: newPosition
]

{ #category : 'move' }
Spaceship >> moveToPosition: aPosition [

	aPosition negative ifTrue: [
		Error signal: 'The spaceship cannot move to a negative position' ].
	position := aPosition
	"Para mi esta mal y se deberia sumar en vez de setear"
]

{ #category : 'move' }
Spaceship >> moveUpTo: aBoardSize [

	| positionsToAdvance newPosition |
	positionsToAdvance := dice
		                      inject: 0
		                      into: [ :totalPositions :aDice |
		                      totalPositions + aDice roll ].
	newPosition := position + positionsToAdvance.
	newPosition := newPosition min: aBoardSize.
	self moveToPosition: newPosition
]
