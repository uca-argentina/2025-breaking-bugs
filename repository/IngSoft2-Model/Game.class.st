Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'theGameHasFinished',
		'board',
		'spaceships',
		'positionTable'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> with: aBoard and: spaceships [

	^ self new initializeWith: aBoard and: spaceships
]

{ #category : 'adding' }
Game >> addSpaceship: aSpaceship [

	spaceships add: aSpaceship
]

{ #category : 'testing' }
Game >> checkIfGameHasAlreadyFinished [

	theGameHasFinished ifTrue: [
		Error signal: 'Cannot play a turn after the game has finished.' ]
]

{ #category : 'testing' }
Game >> checkPositionOfSpaceships: aPosition [

	^ spaceships anySatisfy: [ :aSpaceship |
		  aSpaceship isAtPosition: aPosition ]
]

{ #category : 'behavior' }
Game >> getPositionTable [

	^ positionTable
]

{ #category : 'testing' }
Game >> hasABoard [

	^ board notNil
]

{ #category : 'initialization' }
Game >> hasFinished [

	^ theGameHasFinished
]

{ #category : 'testing' }
Game >> hasSpaceships [

	^ spaceships notEmpty
]

{ #category : 'initialization' }
Game >> initializeWith: aBoard and: aCollectionOfSpacehips [

	theGameHasFinished := false.
	spaceships := aCollectionOfSpacehips.
	board := aBoard
]

{ #category : 'roll' }
Game >> playTurn [

	self checkIfGameHasAlreadyFinished.
	board move: spaceships ifGameDidntFinish: theGameHasFinished.
	"board move: spaceships"
	theGameHasFinished := board verifyIfAnySpaceshipReachedFinishLine:
		                      spaceships.
	positionTable := theGameHasFinished ifTrue: [
		                 board createPositionTable: spaceships ]
]
