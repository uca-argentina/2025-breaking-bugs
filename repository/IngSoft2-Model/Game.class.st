Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'spaceships',
		'dice',
		'hasFinished'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Game >> checkIfGameHasAlreadyFinished [

	hasFinished ifTrue: [
		Error signal: 'Cannot play a turn after the game has finished.' ]
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
Game >> initializeWith: aBoard and: aCollectionOfSpacehips and: aCollectionOfDice [

	hasFinished := false.
	spaceships := aCollectionOfSpacehips.
	board := aBoard.
	dice := aCollectionOfDice.
]

{ #category : 'roll' }
Game >> playSpaceshipTurn: aSpaceship [
	| numberOfSquares newPosition|
	numberOfSquares := self getAllDiceValuesFrom: dice.
	
	newPosition := numberOfSquares + aSpaceship getPosition.
	newPosition := board correctPositionAfterWormholeIfNeeded: newPosition.
	newPosition :=  board correctPositionIfPassTheLine: newPosition.
	hasFinished := board checkIfSpaceshipWon: newPosition.
	aSpaceship moveToPosition: newPosition.
]

{ #category : 'roll' }
Game >> playTurn [

	self checkIfGameHasAlreadyFinished.
	spaceships do: [ :aSpaceship |
    self hasFinished ifFalse: [ self playSpaceshipTurn: aSpaceship ] ].

]
