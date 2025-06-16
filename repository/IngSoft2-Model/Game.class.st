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
		'activatedAtomicBomb'
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
	spaceships := aCollectionOfSpacehips.
	board := aBoard.
	dice := aCollectionOfDice.
	lapsToWin := aNumberOfLaps.
	battle := Battle with: spaceships and: dice.
]

{ #category : 'behavior' }
Game >> playRound [

	self playRoundUsingCardOf: nil.
]

{ #category : 'behavior' }
Game >> playRoundSkipping: aSpaceshipCollection [ 

	self checkIfGameHasAlreadyFinished.
	(spaceships reject: [ :aSpaceship | aSpaceshipCollection includes: aSpaceship ])
	do: [ :aSpaceship |
		self hasFinished ifFalse: [ self playSpaceshipTurn: aSpaceship ] ].
	
	aSpaceshipCollection do: [ :aSpaceship | aSpaceship rechargeShields ].

]

{ #category : 'behavior' }
Game >> playRoundUsingCardOf: theSpaceship [

	| activeSpaceships penalizeSpaceships |
	activatedAtomicBomb := false.
	self checkIfGameHasAlreadyFinished.
	activeSpaceships := spaceships select: [ :aSpaceship |
		                    aSpaceship canPlay ].
	activeSpaceships do: [ :aSpaceship |
		self hasFinished ifFalse: [
			self playSpaceshipTurn: aSpaceship.
			theSpaceship ifNotNil: [
				(aSpaceship = theSpaceship) ifTrue: [ aSpaceship useCard ] ] ] ].

	penalizeSpaceships := spaceships select: [ :aSpaceship |
		                      aSpaceship getShields = 0 ].
	penalizeSpaceships do: [ :aSpaceship | aSpaceship penalize ]
]

{ #category : 'roll' }
Game >> playSpaceshipTurn: aSpaceship [

	| positionsToAdvance newPosition |
	positionsToAdvance := self getAllDiceValuesFrom: dice.
	
	newPosition :=  aSpaceship obtainNewPosition: positionsToAdvance.
	newPosition := board correctPositionAfterWormholeIfNeeded: newPosition.
	newPosition := board correctPositionIf: aSpaceship passTheLine: newPosition withLapLimit: lapsToWin.
	aSpaceship moveToPosition: newPosition.
	
	board applyTileEffectTo: aSpaceship in: self.
	
	activatedAtomicBomb ifFalse: [battle checkForBattleIfNeededWith: aSpaceship].
	hasFinished := aSpaceship hasReached: lapsToWin.
	
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
