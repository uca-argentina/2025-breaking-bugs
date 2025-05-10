Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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

	| aGame aSpaceship |
	aGame := Game create.
	aSpaceship := Spaceship new.
	aGame add: aSpaceship.
	self assert: (aGame hasPlayers).
]

{ #category : 'tests' }
GameTest >> testWhenGameCreatedItDoesntFinish [

	| aGame |
	aGame := Game create.
	self deny: aGame finish
]
