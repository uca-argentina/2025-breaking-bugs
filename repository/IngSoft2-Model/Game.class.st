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
		'lastTileEffectApplied',
		'turnIndex'
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
	cardsThrown := NoEffectCard new.
	lastTileEffectApplied := NoEffect new.
	turnIndex := 1.

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
	self checkIfGameHasAlreadyFinished.
	activatedAtomicBomb := false.

	1 to: spaceships size do: [ :i |
		self hasFinished ifFalse: [
			self playTurnUsing: aCard of: theSpaceship to: targetSpaceship
		]
	].

	(spaceships select: [ :s | s getShields = 0 ])
		do: [ :s | s penalize ].


]

{ #category : 'behavior' }
Game >> playSpaceshipTurn: aSpaceship usingCard: aCard against: aTargetSpaceship [
    | positionsToAdvance card targetSpaceship aSpaceshipNew |
    positionsToAdvance := self getAllDiceValuesFrom: dice.
    board move: aSpaceship by: positionsToAdvance withLapLimit: lapsToWin.

    board applyTileEffectTo: aSpaceship in: self.
    aSpaceshipNew := spaceships detect: [ :each | each = aSpaceship ].
    
    activatedAtomicBomb ifFalse: [battle checkForBattleIfNeededWith: aSpaceshipNew].
    hasFinished := aSpaceshipNew hasReached: lapsToWin.
    
    targetSpaceship := self checkValid: aTargetSpaceship for: aSpaceshipNew inCard: aCard.
    card := aCard checkIfEffectCanBeApplyToTarget: targetSpaceship.
    card := aSpaceshipNew extractCardIfAvailable: card.
    
    card class = CancelationCard
        ifTrue: [ card implementEffect: activePermanentCards last by: aSpaceshipNew to: aTargetSpaceship in: self ]
        ifFalse: [ card implementEfectBy: aSpaceshipNew on: targetSpaceship in: self ].

    card isPermanent ifTrue: [ activePermanentCards add: card ].


]

{ #category : 'behavior' }
Game >> playTurnUsing: aCard of: theSpaceship to: targetSpaceship [

	| spaceshipToPlay cardToPlay |

	self checkIfGameHasAlreadyFinished.

	spaceshipToPlay := spaceships at: turnIndex.

	(spaceshipToPlay canPlay) ifTrue: [
		cardToPlay := (spaceshipToPlay = theSpaceship)
			ifTrue: [ aCard ]
			ifFalse: [ NoEffectCard new ].

		self hasFinished ifFalse: [
			self playSpaceshipTurn: spaceshipToPlay usingCard: cardToPlay against: targetSpaceship
		].
	].

	turnIndex := turnIndex + 1.
	turnIndex > spaceships size ifTrue: [ turnIndex := 1 ].

]

{ #category : 'initialization' }
Game >> positionAfterMovingBack: positionsToGoBack for: aSpaceship [
	^ board positionAfterMovingBack: positionsToGoBack for: aSpaceship.
]

{ #category : 'behavior' }
Game >> registerAppliedEffect: anEffect [

	lastTileEffectApplied := anEffect
]

{ #category : 'behavior' }
Game >> registerThrownCard: aCard [

	cardsThrown := aCard
]

{ #category : 'getter' }
Game >> spaceshipMatching: aSpaceship [

	^ (spaceships detect: [ :each | each = aSpaceship ]) deepCopy.
]

{ #category : 'behavior' }
Game >> spaceshipsExcept: aSpaceship do: aBlock [
	(spaceships reject: [ :each | each = aSpaceship ]) do: aBlock

]
