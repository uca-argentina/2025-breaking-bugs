Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'spaceships',
		'dice',
		'hasFinished',
		'battle',
		'lapsToWin'
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
	boardSize := self getBoardSize.
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

{ #category : 'behavior' }
Game >> getAllDiceValuesFrom: diceCollection [

	^ diceCollection
		  inject: 0
		  into: [ :sumOfValues :aDie | sumOfValues + aDie roll ]
]

{ #category : 'behavior' }
Game >> getBoardSize [
	^ board getSize 
]

{ #category : 'behavior' }
Game >> getPositionTable [
    hasFinished ifFalse: [ self error: 'Cannot get position table before game ends.' ].
    ^ board createPositionTable: spaceships.

]

{ #category : 'behavior' }
Game >> getSpaceships [

	^ spaceships
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

	| activeSpaceships penalizeSpaceships |
	self checkIfGameHasAlreadyFinished.
	activeSpaceships := spaceships select: [ :aSpaceship | aSpaceship canPlay ].
	activeSpaceships do: [ :aSpaceship |
		self hasFinished ifFalse: [ self playSpaceshipTurn: aSpaceship ] ].

	penalizeSpaceships := spaceships select: [ :aSpaceship | aSpaceship getShields = 0 ].
	penalizeSpaceships do: [ :aSpaceship | aSpaceship penalize ]
]

{ #category : 'behavior' }
Game >> playRoundSkipping: aSpaceshipCollection [ 

	self checkIfGameHasAlreadyFinished.
	(spaceships reject: [ :aSpaceship | aSpaceshipCollection includes: aSpaceship ])
	do: [ :aSpaceship |
		self hasFinished ifFalse: [ self playSpaceshipTurn: aSpaceship ] ].
	
	aSpaceshipCollection do: [ :aSpaceship | aSpaceship rechargeShields ].

]

{ #category : 'roll' }
Game >> playSpaceshipTurn: aSpaceship [

	| positionsToAdvance newPosition  flag |
	positionsToAdvance := self getAllDiceValuesFrom: dice.
	
	newPosition := positionsToAdvance + aSpaceship getPosition.
	newPosition := board correctPositionAfterWormholeIfNeeded: newPosition.
	newPosition := board correctPositionIf: aSpaceship passTheLine: newPosition withLapLimit: lapsToWin.
	aSpaceship moveToPosition: newPosition.
	flag:=board hasAtomicBombAt: newPosition.
	
	board applyTileEffectTo: aSpaceship in: self.
	newPosition := board
		               correctPositionIf: aSpaceship
		               passTheLine: aSpaceship getPosition
		               withLapLimit: lapsToWin.
	aSpaceship moveToPosition: newPosition.
	
	( flag)ifFalse:[ battle checkForBattleIfNeededWith: aSpaceship].
	hasFinished := aSpaceship hasReached: lapsToWin.
	
]
