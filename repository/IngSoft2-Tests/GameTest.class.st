Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> testIsInvalidIfASpacehipMovesToWormholeEntryThenItEndsInAnotherPositionThanTheWormholeExitValue [

	| aGame aSpaceship aBoard |
	aBoard := Board withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	aSpaceship := Spaceship with: (FixedDice onFace: 4).
	aGame addPlayer: aSpaceship.
	
	aGame rollDices.
	self deny: (aGame checkPositionOfPlayers: 19).
	
]

{ #category : 'tests' }
GameTest >> testIsValidIfASpacehipMovesCertainPosition [

	| aGame aSpaceship aBoard |
	aBoard := Board withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	aSpaceship := Spaceship with: (FixedDice onFace: 5).
	aGame addPlayer: aSpaceship.
	aGame rollDices.
	self assert: (aGame checkPositionOfPlayers: 5).
	
]

{ #category : 'tests' }
GameTest >> testIsValidIfASpacehipMovesToWormholeEntryThenItEndsInWormholeExitValue [

	| aGame aSpaceship aBoard |
	aBoard := Board withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	aSpaceship := Spaceship with: (FixedDice onFace: 4).
	aGame addPlayer: aSpaceship.
	
	aGame rollDices.
	self assert: (aGame checkPositionOfPlayers: 9).
	
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
	aGame addPlayer: aSpaceship.
	self assert: (aGame hasPlayers).
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
GameTest >> testWhenGameCreatedItDoesntFinish [

	| aGame |
	aGame := Game create.
	self deny: aGame finish
]
