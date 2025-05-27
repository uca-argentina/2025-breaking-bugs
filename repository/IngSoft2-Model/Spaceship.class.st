Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'laps',
		'shields'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Spaceship >> getPosition [

	^ position
]

{ #category : 'behavior' }
Spaceship >> getShields [
	^ shields.
]

{ #category : 'behavior' }
Spaceship >> incrementLapsBy: lapsIncremented [
	laps := laps + lapsIncremented.
]

{ #category : 'initialization' }
Spaceship >> initialize [

	position := 0.
	laps := 0.
	shields := 3.
]

{ #category : 'testing' }
Spaceship >> isAtPosition: aPosition [

	^ position = aPosition
]

{ #category : 'behavior' }
Spaceship >> lapsCompleted [
	^ laps.
]

{ #category : 'behavior' }
Spaceship >> lowerAShield [
	shields > 1 ifTrue: [ shields := shields - 1].
]

{ #category : 'move' }
Spaceship >> moveToPosition: aPosition [

	aPosition negative ifTrue: [
		Error signal: 'The spaceship cannot move to a negative position' ].
	position := aPosition
]
