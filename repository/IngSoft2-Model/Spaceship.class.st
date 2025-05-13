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
Spaceship class >> new [

	| aSpaceship dice |
	aSpaceship := super new.
	dice := OrderedCollection new.
	dice add: Dice new.
	^ aSpaceship initializeWith: dice
]

{ #category : 'instance creation' }
Spaceship class >> with: dice [

	^ self new initializeWith: dice
]

{ #category : 'behavior' }
Spaceship >> getAllDiceValuesFrom: diceCollection [

	^ diceCollection
		  inject: 0
		  into: [ :totalPositions :aDie | totalPositions + aDie roll ]
]

{ #category : 'initialization' }
Spaceship >> initializeWith: aCollectionOfDice [

	position := 0.
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
]

{ #category : 'move' }
Spaceship >> moveUpTo: aBoardSize [

	| positionsToAdvance newPosition |
	positionsToAdvance := self getAllDiceValuesFrom: dice.
	newPosition := position + positionsToAdvance.
	newPosition := newPosition min: aBoardSize.
	self moveToPosition: newPosition
]

{ #category : 'move' }
Spaceship >> moveUpTo: aBoardSize ifGameDidntFinish: gameHasFinished [

	| newPosition |
	newPosition := gameHasFinished
		               ifTrue: [ position ]
		               ifFalse: [
		               position + (self getAllDiceValuesFrom: dice) min: aBoardSize ].
	self moveToPosition: newPosition
]
