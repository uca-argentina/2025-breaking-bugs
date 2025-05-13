Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'spaceships',
		'positionTable',
		'hasFinished'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> with: aBoard and: spaceships [

	^ self new initializeWith: aBoard and: spaceships
]

{ #category : 'testing' }
Game >> checkIfGameHasAlreadyFinished [

	hasFinished ifTrue: [
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

	^ hasFinished
]

{ #category : 'testing' }
Game >> hasSpaceships [

	^ spaceships notEmpty
]

{ #category : 'initialization' }
Game >> initializeWith: aBoard and: aCollectionOfSpacehips [

	hasFinished := false.
	spaceships := aCollectionOfSpacehips.
	board := aBoard
]

{ #category : 'roll' }
Game >> playTurn [

	self checkIfGameHasAlreadyFinished.
	board move: spaceships.
	hasFinished := board verifyIfAnySpaceshipReachedFinishLine:
		                      spaceships.
		
	positionTable := hasFinished ifTrue: [
		                 board createPositionTable: spaceships ]
]
