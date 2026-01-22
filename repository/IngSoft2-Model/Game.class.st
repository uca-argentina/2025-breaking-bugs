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
		'cardsThrown',
		'lastTileEffectApplied'
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
Game >> getCardsOf: aSpaceship [ 
	| spaceshipResult |
	spaceshipResult := spaceships detect: [ :each |
		                   each = aSpaceship ].
	^ spaceshipResult getCards.
]

{ #category : 'getter' }
Game >> getLapsCompletedOf: aSpaceship [

	| spaceshipResult |
	spaceshipResult := spaceships detect: [ :each |
		                   each = aSpaceship ].
	^ spaceshipResult getLapsCompleted.
]

{ #category : 'getter' }
Game >> getMercenariesOf: aSpaceship [ 
	| spaceshipResult |
	spaceshipResult := spaceships detect: [ :each |
		                   each = aSpaceship ].
	^ spaceshipResult getMercenaries.
]

{ #category : 'getter' }
Game >> getPositionOf: aSpaceship [
    | spaceshipResult |
spaceshipResult := (spaceships detect: [:each | each = aSpaceship]).
	 ^ (spaceshipResult getPosition).
]

{ #category : 'behavior' }
Game >> getPositionTable [
    hasFinished ifFalse: [ self error: 'Cannot get position table before game ends.' ].
    ^ board createPositionTable: spaceships.

]

{ #category : 'getter' }
Game >> getShieldsOf: aSpaceship [ 
    | spaceshipResult |
spaceshipResult := (spaceships detect: [:each | each = aSpaceship]).
	 ^ (spaceshipResult getShields).
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
	cardsThrown := NoEffectCard new.
	lastTileEffectApplied := NoEffect new
]

{ #category : 'accessing' }
Game >> lastActivePermanentCard [

	^ activePermanentCards removeLast
]

{ #category : 'behavior' }
Game >> lastCardThrown [

	^ cardsThrown
]

{ #category : 'accessing' }
Game >> lastTileEffectApplied [

	^ lastTileEffectApplied
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
Game >> numberOfActivePermanentCards [

	^ activePermanentCards size
]

{ #category : 'behavior' }
Game >> playInstant: anInstantCard of: aSpaceship on: anotherCard [

	self
		playInstant: anInstantCard
		of: aSpaceship
		with: anotherCard 
		to: nil
]

{ #category : 'behavior' }
Game >> playInstant: aRepeatCard of: aSpaceship to: aTargetSpaceship [

	self
		playInstant: aRepeatCard
		of: aSpaceship
		with: NoEffectCard new
		to: aTargetSpaceship
]

{ #category : 'behavior' }
Game >> playInstant: anInstantCard of: aSpaceship with: aPermanentCard to: aTargetSpaceship [

	| realCard instantCard aSpaceshipInGame aTargetSpaceshipInGame |
	aSpaceshipInGame := spaceships detect: [ :each | each = aSpaceship ].
	aTargetSpaceshipInGame := spaceships
		                          detect: [ :each | each = aTargetSpaceship ]
		                          ifNone: [ nil ].
	instantCard := aSpaceshipInGame extractCardIfAvailable: anInstantCard.
	instantCard isInstant ifFalse: [ ^ nil ].
	realCard := activePermanentCards
		            detect: [ :each | each = aPermanentCard ]
		            ifNone: [
			            NoEffectCard new
			            "Error signal: 'The card wanted is not active'" ].
	instantCard
		implementEffect: realCard
		by: aSpaceshipInGame
		to: aTargetSpaceshipInGame
		in: self.
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
		card implementEffect: activePermanentCards last by:aSpaceshipNew to: aTargetSpaceship in: self.]
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
Game >> registerAppliedEffect: anEffect [

	lastTileEffectApplied := anEffect
]

{ #category : 'behavior' }
Game >> registerThrownCard: aCard [

	cardsThrown := aCard
]

{ #category : 'behavior' }
Game >> updateValues: aSpaceship [
	spaceships := spaceships collect: [ :each |
		each = aSpaceship ifTrue: [ aSpaceship ] ifFalse: [ each ] ].
]
