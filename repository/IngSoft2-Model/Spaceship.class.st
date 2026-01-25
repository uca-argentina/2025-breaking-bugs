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
		'id',
		'owner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Spaceship class >> new [

	| randomCards |
	randomCards := OrderedCollection
		               with: RandomCard obtainCard
		               with: RandomCard obtainCard.
	^ self basicNew
		  initializeWithPosition: 0
		  laps: 0
		  shields: 3
		  turnsPenalize: -1
		  cards: randomCards
		  velocity: 0
		  mercenaries: OrderedCollection new
		  owner: false
		  id: 'Nave-' , (0 to: 9999) atRandom asString
]

{ #category : 'instance creation' }
Spaceship class >> with: cardsCollection [

	^ self basicNew
		  initializeWithPosition: 0
		  laps: 0
		  shields: 3
		  turnsPenalize: -1
		  cards: cardsCollection
		  velocity: 0
		  mercenaries: OrderedCollection new
		  owner: false
		  id: 'Nave-' , (0 to: 9999) atRandom asString
]

{ #category : 'adding' }
Spaceship >> = anotherSpaceship [
	| boolean |
	anotherSpaceship ifNil: [ ^ false ].
	boolean := (id = anotherSpaceship getId).
	^ boolean.
	
]

{ #category : 'adding' }
Spaceship >> addNewCard: aCard [ 
    cards add: aCard.
	
]

{ #category : 'as yet unclassified' }
Spaceship >> adjustPositionAfterMoving: newPosition onBoardOfSize: aBoardSize withLapLimit: lapLimit [
    | lapsCompleted positionInBoard |
    
    "Delegar cálculos a Distance"
    lapsCompleted := aBoardSize calculateLapsIn: newPosition.
    positionInBoard := aBoardSize calculatePositionIn: newPosition.
    
    "Usar métodos existentes de Spaceship"
    self incrementLapsBy: lapsCompleted.
    
    "Si alcanzó el límite, devolver la posición final (finish line)"
    ^ (self hasReached: lapLimit)
        ifTrue: [ aBoardSize toInternalValue ]
        ifFalse: [ positionInBoard ]
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
	"REVISAR"
    foundCard := cards detect: [ :each | each class = aCard class  ] ifNone: [ NoEffectCard new ].
    cards remove: foundCard ifAbsent: [].
    ^ foundCard
]

{ #category : 'behavior' }
Spaceship >> fire: aSpaceship [ 
	mercenaries remove: aSpaceship ifAbsent: [].
]

{ #category : 'getter' }
Spaceship >> getCards [

	^ cards
]

{ #category : 'getter' }
Spaceship >> getId [

	^ id.
]

{ #category : 'getter' }
Spaceship >> getLapsCompleted [

	^ laps
]

{ #category : 'getter' }
Spaceship >> getMercenaries [
	^ mercenaries.
]

{ #category : 'testing' }
Spaceship >> getPosition [

	^ position
]

{ #category : 'getter' }
Spaceship >> getShields [

	^ shields
]

{ #category : 'testing' }
Spaceship >> hasHimAsMercenary: aSpaceship [ 
	^ mercenaries includes: aSpaceship.
]

{ #category : 'testing' }
Spaceship >> hasOwner [
	^ owner.
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
	owner := false.
	id := 'Nave-' , (0 to: 9999) atRandom asString
]

{ #category : 'initialization' }
Spaceship >> initializeWithPosition: aPosition laps: aLaps shields: aShields turnsPenalize: aTurns cards: aCollectionOfCards velocity: aVelocity mercenaries: aMercenaries owner: anOwner id: anId [

	position := aPosition.
	laps := aLaps.
	shields := aShields.
	turnsPenalize := aTurns.
	cards := aCollectionOfCards.
	velocity := aVelocity.
	mercenaries := aMercenaries.
	owner := anOwner.
	id := anId.

	^ self
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
Spaceship >> makeSpaceshipOwnedBy: aSpaceship [ 
	owner := true.

]

{ #category : 'behavior' }
Spaceship >> moveAtHigherVelocity [

	velocity := velocity + 1
]

{ #category : 'behavior' }
Spaceship >> moveAtLowerVelocity [

	velocity := velocity - 1
]

{ #category : 'move' }
Spaceship >> moveToPosition: aPosition [

	aPosition negative ifTrue: [
		Error signal: 'The spaceship cannot move to a negative position' ].
	position := aPosition + velocity
]

{ #category : 'getter' }
Spaceship >> numberOfMercenaries [

	^ mercenaries size
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
