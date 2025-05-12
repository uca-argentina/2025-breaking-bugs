Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> testIsInvalidIfASpacehipMovesToWormholeEntryThenItEndsInAnotherPositionThanTheWormholeExitValue [

	| aGame aSpaceship aBoard dice |
	aBoard := Board withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	
	
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 3).
	aSpaceship := Spaceship with: dice.
	aGame addSpaceship: aSpaceship.
	
	aGame playTurn.
	self deny: (aGame checkPositionOfSpaceships: 19).
	
]

{ #category : 'tests' }
GameTest >> testIsValidIfASpacehipMovesCertainPosition [

	| aGame aSpaceship aBoard dice |
	aBoard := Board withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 5).
	aSpaceship := Spaceship with: dice.
	
	aGame addSpaceship: aSpaceship.
	aGame playTurn.
	self assert: (aGame checkPositionOfSpaceships: 5).
	
]

{ #category : 'tests' }
GameTest >> testIsValidIfASpacehipMovesToWormholeEntryThenItEndsInWormholeExitValue [

	| aGame aSpaceship aBoard dice |
	aBoard := Board withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 4).
	aSpaceship := Spaceship with: dice.
	aGame addSpaceship: aSpaceship.
	
	aGame playTurn.
	self assert: (aGame checkPositionOfSpaceships: 9).
	
]

{ #category : 'tests' }
GameTest >> testIsValidIfASpacehipMovesToWormholeExitThenItEndsInWormholeEntryValue [

	| aGame aSpaceship aBoard dice |
	aBoard := Board withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 9).
	aSpaceship := Spaceship with: dice.
	aGame addSpaceship: aSpaceship.
	
	aGame playTurn.
	self assert: (aSpaceship isAtPosition: 4).
	
]

{ #category : 'tests' }
GameTest >> testIsValidIfGameHasABoard [

	| aGame aSize aBoard |
	aSize := 20.
	aBoard := Board withSize: aSize andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	self assert: (aGame hasABoard).
]

{ #category : 'tests' }
GameTest >> testIsValidIfGameHasASpacehip [

	| aGame aSpaceship aBoard |
	aBoard := Board withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	aSpaceship := Spaceship new.
	aGame addSpaceship: aSpaceship.
	self assert: (aGame hasSpaceships).
]

{ #category : 'tests' }
GameTest >> testIsValidIfGameHasAtLeastOneDice [

	| aGame aSize aBoard aFixedDice |
	aSize := 20.
	aFixedDice := FixedDice onFace: 5.
	aBoard := Board withSize: aSize andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	aGame addDice: aFixedDice.
	self assert: (aGame hasDices).
]

{ #category : 'tests' }
GameTest >> testWhenASpaceshipReachesTheFinishLineTheGameEnds [

	| aGame aBoard aSpaceship dice |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 3.
	aGame := Game withBoard: aBoard.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 6).
	aSpaceship := Spaceship with: dice.
	aGame addSpaceship: aSpaceship.
	
	aGame playTurn.

	self assert: aGame finish
]

{ #category : 'tests' }
GameTest >> testWhenGameCreatedItDoesntFinish [

	| aGame aBoard |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 5.
	aGame := Game withBoard: aBoard.
	self deny: aGame finish
]

{ #category : 'tests' }
GameTest >> testWhenLandingOnAWormholeConnectedToTheFinishLineTheGameEnds [

	| aGame aBoard aSpaceship dice |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 6.
	aGame := Game withBoard: aBoard.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 2).
	aSpaceship := Spaceship with: dice.
	aGame addSpaceship: aSpaceship.

	aGame playTurn.

	self assert: aGame finish
]

{ #category : 'tests' }
GameTest >> testWhenTheSpaceshipMovesBeyondTheFinishLineTheGameEnds [

	| aGame aBoard aSpaceship dice |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 3.
	aGame := Game withBoard: aBoard.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 8).
	aSpaceship := Spaceship with: dice.
	aGame addSpaceship: aSpaceship.

	aGame playTurn.

	self assert: aGame finish
]

{ #category : 'tests' }
GameTest >> testWhenTheSpaceshipMovesWithTwoDicesBeyondTheFinishLineTheGameEnds [

	| aGame aBoard aSpaceship dice |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 3.
	aGame := Game withBoard: aBoard.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 2).
	dice add: (FixedDice onFace: 4).
	aSpaceship := Spaceship with: dice.
	aGame addSpaceship: aSpaceship.

	aGame playTurn.

	self assert: aGame finish
]
