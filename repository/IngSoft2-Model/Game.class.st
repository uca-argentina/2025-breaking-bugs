Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'spaceships',
		'dice',
		'hasFinished',
		'battle',
		'lapsToWin',
		'activatedAtomicBomb',
		'activePermanentCards',
		'cardsThrown'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Game class >> with: aBoard and: spaceships and: dice and: lapsToWin [
	^ self new initializeWith: aBoard and: spaceships and: dice and: lapsToWin.
]

{ #category : 'testing' }
Game >> checkIfGameHasAlreadyFinished [

	hasFinished ifTrue: [
		Error signal: 'Cannot play a turn after the game has finished.' ]
]

{ #category : 'behavior' }
Game >> checkValid: aTargetSpaceship for: spaceship inCard: aCard [

	|spaceshipSearch|
    spaceshipSearch := (spaceships select: [ :s | s ~= spaceship ]).
    spaceshipSearch := spaceshipSearch detect: [ :s | s = aTargetSpaceship ]  ifNone: [ ^ nil].
	 spaceshipSearch hasOwner  ifTrue: [ ^ nil ].
	 ^ spaceshipSearch.
    
]

{ #category : 'roll' }
Game >> correctPositionOf: aSpaceship to: numberOfPositionsToGoBack [
	| currentPosition newPosition boardSize currentLap |
	boardSize := board getSize.
	currentPosition := aSpaceship getPosition.
	currentLap := aSpaceship getLapsCompleted.
	
	newPosition := currentPosition - numberOfPositionsToGoBack.

	newPosition < 0 ifTrue: [
		currentLap = 0 ifTrue: [
			^ 0
		]. 
		aSpaceship decrementLapsBy: 1.
		^ boardSize + newPosition 
	].

	^ newPosition

]

{ #category : 'initialization' }
Game >> disableBattleForThisTurn [

	^ activatedAtomicBomb := true.
]

{ #category : 'behavior' }
Game >> getAllDiceValuesFrom: diceCollection [

	^ diceCollection
		  inject: 0
		  into: [ :sumOfValues :aDie | sumOfValues + aDie roll ]
]

{ #category : 'behavior' }
Game >> getObjectGetter [
	^ Getters with: (spaceships deepCopy) and: (activePermanentCards deepCopy).
]

{ #category : 'behavior' }
Game >> getPositionTable [
    hasFinished ifFalse: [ self error: 'Cannot get position table before game ends.' ].
    ^ board createPositionTable: spaceships.

]

{ #category : 'initialization' }
Game >> hasFinished [

	^ hasFinished
]

{ #category : 'initialization' }
Game >> initializeWith: aBoard and: aCollectionOfSpacehips and: aCollectionOfDice and: aNumberOfLaps [

	hasFinished := false.
	spaceships := aCollectionOfSpacehips deepCopy.
	board := aBoard.
	dice := aCollectionOfDice.
	lapsToWin := aNumberOfLaps.
	battle := Battle with: spaceships and: dice.
	activePermanentCards := OrderedCollection new.
	cardsThrown := OrderedCollection new
]

{ #category : 'accessing' }
Game >> lastActivePermanentCard [

	^ activePermanentCards removeLast
]

{ #category : 'behavior' }
Game >> lastCardThrown [
	|lastCardThrown|
	cardsThrown isEmpty ifTrue: [ ^ NoEffectCard new ].
	lastCardThrown := cardsThrown last.
	^ lastCardThrown deepCopy.
]

{ #category : 'behavior' }
Game >> makeAllSpaceShipsMoveAtHigherVelocity [

	spaceships do: [ :spaceship |
		spaceship moveAtHigherVelocity ]
]

{ #category : 'behavior' }
Game >> makeAllSpaceShipsMoveAtLowerVelocity [

	spaceships do: [ :spaceship |
		spaceship moveAtLowerVelocity ]
]

{ #category : 'behavior' }
Game >> play: anInstantCard of: aSpaceship on: aSpeedCard [ 
	self play: anInstantCard of: aSpaceship with: aSpeedCard to: nil.
]

{ #category : 'behavior' }
Game >> play: anInstantCard of: aSpaceship with: aPermanentCard to: aTargetSpaceship [ 

	| realCard instantCard aSpaceshipInGame|
	aSpaceshipInGame := spaceships detect: [ :each | each = aSpaceship ].
	instantCard := aSpaceshipInGame extractCardIfAvailable: anInstantCard.
	instantCard isInstant ifFalse:[^nil].
	realCard := activePermanentCards
		            detect: [ :each | each = aPermanentCard ]
		            ifNone: [
		            Error signal: 'The card wanted is not active' ].
	instantCard implementEffect: realCard to: aTargetSpaceship in: self.
	activePermanentCards := activePermanentCards reject: [ :card |
		                        card == realCard ]
]

{ #category : 'behavior' }
Game >> playRound [

	self playRoundUsing: (NoEffectCard new) of: nil.
]

{ #category : 'behavior' }
Game >> playRoundSkipping: aSpaceshipCollection [ 

	self checkIfGameHasAlreadyFinished.
	(spaceships reject: [ :aSpaceship | aSpaceshipCollection includes: aSpaceship ])
	do: [ :aSpaceship |
		self hasFinished ifFalse: [ 
			self playSpaceshipTurn: aSpaceship usingCard: (NoEffectCard new) against: nil ] ].

	(spaceships select: [ :aSpaceship | aSpaceshipCollection includes: aSpaceship ])
	do: [ :aSpaceship | aSpaceship rechargeShields ].


]

{ #category : 'behavior' }
Game >> playRoundUsing: aCard of: theSpaceship [

	self playRoundUsing: aCard of: theSpaceship to: nil.
]

{ #category : 'behavior' }
Game >> playRoundUsing: aCard of: theSpaceship to: targetSpaceship [

	| activeSpaceships penalizeSpaceships card cardToPlay |
	activatedAtomicBomb := false.
	card := aCard.
	self checkIfGameHasAlreadyFinished.
	activeSpaceships := spaceships select: [ :aSpaceship |
		                    aSpaceship canPlay ].
	activeSpaceships do: [ :aSpaceship |
		self hasFinished ifFalse: [
			cardToPlay := (aSpaceship = theSpaceship) 
                ifTrue: [ aCard ] 
                ifFalse: [ NoEffectCard new ].
			self playSpaceshipTurn: aSpaceship usingCard: cardToPlay against: targetSpaceship]].
	
	penalizeSpaceships := spaceships select: [ :aSpaceship |
		                      aSpaceship getShields = 0 ].
	penalizeSpaceships do: [ :aSpaceship | aSpaceship penalize ]

]

{ #category : 'behavior' }
Game >> playSpaceshipTurn: aSpaceship usingCard: aCard against: aTargetSpaceship [

	| positionsToAdvance newPosition card targetSpaceship aSpaceshipNew|
	positionsToAdvance := self getAllDiceValuesFrom: dice.
	
	newPosition :=  aSpaceship obtainNewPosition: positionsToAdvance.
	newPosition := board correctPositionAfterWormholeIfNeeded: newPosition.
	newPosition := board correctPositionIf: aSpaceship passTheLine: newPosition withLapLimit: lapsToWin.
	aSpaceship moveToPosition: newPosition.
	
	board applyTileEffectTo: aSpaceship in: self.
	aSpaceshipNew := spaceships detect: [ :each | each = aSpaceship ].
	
	activatedAtomicBomb ifFalse: [battle checkForBattleIfNeededWith: aSpaceshipNew].
	hasFinished := aSpaceshipNew hasReached: lapsToWin.
	
	"Si el destino no es valido entonces la carta pierde su efecto"
	targetSpaceship := self checkValid: aTargetSpaceship for: aSpaceshipNew inCard: aCard.
	card := aCard checkIfEffectCanBeApplyToTarget: targetSpaceship.
	
	card := aSpaceshipNew extractCardIfAvailable: card.
	card class = CancelationCard
		ifTrue: [
		card implementEffect: activePermanentCards last to: aTargetSpaceship in: self.]
		ifFalse: [ card implementEfectBy: aSpaceshipNew on: targetSpaceship in: self ].

	card isPermanent ifTrue: [ activePermanentCards add: card ].


]

{ #category : 'behavior' }
Game >> produceAtomicBombEffectTo: aSpaceship [

	spaceships do: [ :ship |
		ship moveToPosition: 0 .
		ship lowerAShield ].
	self disableBattleForThisTurn.
]

{ #category : 'behavior' }
Game >> produceMoonwalkEffectTo: aSpaceship with: aNumberOfPositionsToGoBack [

	| otherSpaceships newPosition |
	otherSpaceships := spaceships reject: [ :each |
		                   each == aSpaceship ].

	otherSpaceships do: [ :ship |
		newPosition := self correctPositionOf: ship to: aNumberOfPositionsToGoBack.
		ship moveToPosition: newPosition]

]

{ #category : 'behavior' }
Game >> registerThrownCard: aCard [

	cardsThrown add: aCard
]

{ #category : 'behavior' }
Game >> updateValues: aSpaceship [
	spaceships := spaceships collect: [ :each |
		each = aSpaceship ifTrue: [ aSpaceship ] ifFalse: [ each ] ].
]
