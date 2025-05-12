Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'theGameHasFinished',
		'board',
		'dices',
		'spaceships',
		'positionTable'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> withBoard: aBoard [

	^ self new initializeWithBoard: aBoard
]

{ #category : 'adding' }
Game >> addDice: aDice [ 
	dices add: aDice.
]

{ #category : 'adding' }
Game >> addSpaceship: aSpaceship [ 
  spaceships add: aSpaceship.
]

{ #category : 'testing' }
Game >> checkIfGameHasAlreadyFinished [
	theGameHasFinished ifTrue: [ Error signal: 'Cannot play a turn after the game has finished.' ]
]

{ #category : 'testing' }
Game >> checkPositionOfSpaceships: aPosition [
    ^ spaceships anySatisfy: [ :aSpaceship | aSpaceship isAtPosition: aPosition ].
]

{ #category : 'initialization' }
Game >> finish [
	^ theGameHasFinished.
]

{ #category : 'behavior' }
Game >> getPositionTable [
	^ positionTable.
]

{ #category : 'testing' }
Game >> hasABoard [
	^ board notNil.
]

{ #category : 'testing' }
Game >> hasDices [

	^ dices notEmpty
]

{ #category : 'testing' }
Game >> hasSpaceships [
	^ spaceships notEmpty.
]

{ #category : 'initialization' }
Game >> initializeWithBoard: aBoard [ 
	theGameHasFinished := false.
	spaceships := OrderedCollection new.
	board := aBoard.
	dices := OrderedCollection new.
]

{ #category : 'roll' }
Game >> playTurn [
	self checkIfGameHasAlreadyFinished.
	board move: spaceships ifGameDidntFinish: theGameHasFinished.
	"board move: spaceships"
	theGameHasFinished := board verifyIfAnySpaceshipReachedFinishLine: spaceships.
	positionTable := theGameHasFinished ifTrue: [ board createPositionTable: spaceships ]
]
