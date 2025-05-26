Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Spaceship >> getPosition [

	^ position
]

{ #category : 'behavior' }
Spaceship >> incrementLapsBy: lapsIncremented [
	laps := laps + lapsIncremented.
]

{ #category : 'initialization' }
Spaceship >> initialize [

	position := 0.
	laps := 0.
]

{ #category : 'testing' }
Spaceship >> isAtPosition: aPosition [

	^ position = aPosition
]

{ #category : 'behavior' }
Spaceship >> lapsCompleted [
	^ laps.
]

{ #category : 'move' }
Spaceship >> moveToPosition: aPosition [

	aPosition negative ifTrue: [
		Error signal: 'The spaceship cannot move to a negative position' ].
	position := aPosition
]
