Class {
	#name : 'GameCreationTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameCreationTest >> testIsValidIfGameHasABoard [

	| aGame aSize aBoard |
	aSize := 20.
	aBoard := Board withSize: aSize andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	self assert: (aGame hasABoard).
]

{ #category : 'tests' }
GameCreationTest >> testIsValidIfGameHasASpacehip [

	| aGame aSpaceship aBoard |
	aBoard := Board withSize: 20 andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	aSpaceship := Spaceship new.
	aGame addSpaceship: aSpaceship.
	self assert: (aGame hasSpaceships).
]

{ #category : 'tests' }
GameCreationTest >> testIsValidIfGameHasAtLeastOneDice [

	| aGame aSize aBoard aFixedDice |
	aSize := 20.
	aFixedDice := FixedDice onFace: 5.
	aBoard := Board withSize: aSize andWormholeFrom: 4 to: 9.
	aGame := Game withBoard: aBoard.
	aGame addDice: aFixedDice.
	self assert: (aGame hasDices).
]

{ #category : 'tests' }
GameCreationTest >> testWhenGameCreatedItDoesntFinish [

	| aGame aBoard |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 5.
	aGame := Game withBoard: aBoard.
	self deny: aGame finish
]
