Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'laps',
		'shields',
		'turnsPenalize'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
Spaceship >> canPlay [

	^ self getShields > 0
]

{ #category : 'behavior' }
Spaceship >> decrementLapsBy: lapsIncremented [
	
	laps := laps - lapsIncremented
]

{ #category : 'behavior' }
Spaceship >> getLapsCompleted [

	^ laps
]

{ #category : 'testing' }
Spaceship >> getPosition [

	^ position
]

{ #category : 'behavior' }
Spaceship >> getShields [

	^ shields
]

{ #category : 'behavior' }
Spaceship >> hasReached: lapsToWin [

	^ laps >= lapsToWin
]

{ #category : 'behavior' }
Spaceship >> incrementLapsBy: lapsIncremented [

	laps := laps + lapsIncremented
]

{ #category : 'initialization' }
Spaceship >> initialize [

	position := 0.
	laps := 0.
	shields := 3.
	turnsPenalize := -1
]

{ #category : 'testing' }
Spaceship >> isAtPosition: aPosition [

	^ position = aPosition
]

{ #category : 'behavior' }
Spaceship >> lowerAShield [

	shields > 0 ifTrue: [ shields := shields - 1 ]
]

{ #category : 'move' }
Spaceship >> moveToPosition: aPosition [

	aPosition negative ifTrue: [
		Error signal: 'The spaceship cannot move to a negative position' ].
	position := aPosition
]

{ #category : 'behavior' }
Spaceship >> penalize [

	turnsPenalize := turnsPenalize + 1.
	turnsPenalize ~= 2 ifTrue: [ ^ self ].

	self rechargeShields.
	turnsPenalize := 0
]

{ #category : 'behavior' }
Spaceship >> rechargeShields [

	shields := 3
]
