Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
GameTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

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
GameTest >> testRaiseErrorIfATurnWantsToBePlayedWhenTheGameHasAlreadyFinished [

	| aGame aBoard aSpaceship dice |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 3.
	aGame := Game withBoard: aBoard.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 8).
	aSpaceship := Spaceship with: dice.
	aGame addSpaceship: aSpaceship.

	aGame playTurn.
	self
		should: [ aGame playTurn ]
		raise: Error
		withMessageText: 'Cannot play a turn after the game has finished.'.
]

{ #category : 'tests' }
GameTest >> testWhenASpaceshipReachesTheFinishLineBeforeTheOtherThenTheGameEnds [

	| aGame aBoard aSpaceship1 aSpaceship2 dice |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 3.
	aGame := Game withBoard: aBoard.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 6).
	aSpaceship1 := Spaceship with: dice.
	aGame addSpaceship: aSpaceship1.
	aSpaceship2 := Spaceship with: dice.
	aGame addSpaceship: aSpaceship2.
	
	aGame playTurn.

	self assert: aGame hasFinished.
	self assert: (aSpaceship2 isAtPosition: 0).
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

	self assert: aGame hasFinished
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

	self assert: aGame hasFinished
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

	self assert: aGame hasFinished
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

	self assert: aGame hasFinished
]
