Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'aDice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Spaceship class >> with: aDice [

	^ self new initializeWith: aDice
]

{ #category : 'initialization' }
Spaceship >> initialize [

	position := 0
]

{ #category : 'initialization' }
Spaceship >> initializeWith: dice [

	aDice := dice
]

{ #category : 'testing' }
Spaceship >> isAtPosition: aPosition [

	^ position = aPosition
]

{ #category : 'move' }
Spaceship >> move [

	| positionsToAdvance newPosition |
	positionsToAdvance := aDice roll.
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
	positionsToAdvance := aDice roll.
	newPosition := position + positionsToAdvance.
	newPosition := newPosition min: aBoardSize.
	self moveToPosition: newPosition
]
