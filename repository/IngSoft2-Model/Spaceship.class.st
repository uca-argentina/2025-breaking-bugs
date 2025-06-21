Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'laps',
		'shields',
		'turnsPenalize',
		'cards',
		'velocity',
		'mercenaries',
		'id'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Spaceship class >> new [
	"Hay que poner basicNew porque el new solo te hace entrar en loop"
	^ self basicNew initializeWith: (OrderedCollection with: (VelocityCard new) with: (VelocityCard new)).

]

{ #category : 'instance creation' }
Spaceship class >> with: cardsCollection [
	"Hay que poner basicNew porque el new solo te hace entrar en loop"
	^ self basicNew initializeWith: cardsCollection.

]

{ #category : 'comparing' }
Spaceship >> = anotherSpaceship [
	| boolean |
	anotherSpaceship ifNil: [ ^ false ].
	boolean := (position = anotherSpaceship getPosition).
	boolean := boolean and: (shields = anotherSpaceship getShields).
	boolean := boolean and: (cards = anotherSpaceship getCards).
	boolean := boolean and: (laps = anotherSpaceship getLapsCompleted).
	boolean := boolean and: (id = anotherSpaceship getId).
	^ boolean.
	
]

{ #category : 'behavior' }
Spaceship >> canPlay [

	^ self getShields > 0
]

{ #category : 'behavior' }
Spaceship >> decrementLapsBy: lapsIncremented [
	
	laps := laps - lapsIncremented
]

{ #category : 'behavior' }
Spaceship >> extractCardIfAvailable: aCard [ 
	| foundCard |
    foundCard := cards detect: [ :each | each = aCard ] ifNone: [ NoEffectCard new ].
    cards remove: foundCard ifAbsent: [].
    ^ foundCard
]

{ #category : 'behavior' }
Spaceship >> getCards [
	^ cards.
]

{ #category : 'behavior' }
Spaceship >> getId [
	^ id.
]

{ #category : 'behavior' }
Spaceship >> getLapsCompleted [

	^ laps
]

{ #category : 'behavior' }
Spaceship >> getMercenaries [
	^ mercenaries.
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
Spaceship >> initializeWith: aCollectionOfCards [

	position := 0.
	laps := 0.
	shields := 3.
	turnsPenalize := -1.
	cards := aCollectionOfCards.
	velocity := 0.
	mercenaries := OrderedCollection new.
	id := 'Nave-', (1000 to: 9999) atRandom asString.
]

{ #category : 'testing' }
Spaceship >> isAtPosition: aPosition [

	^ position = aPosition
]

{ #category : 'behavior' }
Spaceship >> lowerAShield [

	shields > 0 ifTrue: [ shields := shields - 1 ]
]

{ #category : 'behavior' }
Spaceship >> makeHimOwnerOf: aSpaceship [ 
	mercenaries add: aSpaceship.
]

{ #category : 'behavior' }
Spaceship >> makeSpaceshipMoveAtHigherVelocity [
	velocity := velocity + 1.
]

{ #category : 'behavior' }
Spaceship >> makeSpaceshipOwnedBy: aSpaceship [ 
	"Parte de mercenary tests"
	mercenaries add: aSpaceship.
]

{ #category : 'move' }
Spaceship >> moveToPosition: aPosition [

	aPosition negative ifTrue: [
		Error signal: 'The spaceship cannot move to a negative position' ].
	position := aPosition + velocity.
]

{ #category : 'behavior' }
Spaceship >> numberOfMercenaries [
	^ mercenaries size.
]

{ #category : 'behavior' }
Spaceship >> obtainNewPosition: positionsToAdvance [ 
	^ position + positionsToAdvance.
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

{ #category : 'behavior' }
Spaceship >> useCardOn: targetSpaceship [
	| card |
	card := cards at: 1.
	cards removeFirst.
	card implementEfectBy: self on: targetSpaceship.
]
