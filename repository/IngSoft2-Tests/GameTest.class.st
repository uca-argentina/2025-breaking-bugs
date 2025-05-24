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
GameTest >> testIsValidIfASpacehipMovesCertainPosition [

	| aGame aSpaceship aGameBuilder |
	

	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: 5);
		         build.

	aGame playTurn.
	self assert: (aSpaceship isAtPosition: 5)
]

{ #category : 'tests' }
GameTest >> testIsValidIfASpacehipMovesToWormholeEntryThenItEndsInWormholeExitValue [

	| aGame aSpaceship aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: 4);
		         build.

	aGame playTurn.
	self assert: (aSpaceship isAtPosition: 9)
]

{ #category : 'tests' }
GameTest >> testIsValidIfASpacehipMovesToWormholeExitThenItEndsInWormholeEntryValue [

	| aGame aSpaceship aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 9);
		         build.

	aGame playTurn.
	self assert: (aSpaceship isAtPosition: 4)
]

{ #category : 'tests' }
GameTest >> testRaiseErrorIfATurnWantsToBePlayedWhenTheGameHasAlreadyFinished [

	| aGame aSpaceship aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: 20);
		         build.

	aGame playTurn.
	self
		should: [ aGame playTurn. ]
		raise: Error
		withMessageText: 'Cannot play a turn after the game has finished.'
]

{ #category : 'tests' }
GameTest >> testWhenASpaceshipReachesTheFinishLineBeforeTheOtherThenTheGameEnds [

	| aGame aSpaceship1 aSpaceship2 aGameBuilder finishLine |
	aGameBuilder := GameBuilder new.
	aSpaceship1 := Spaceship new.
	aSpaceship2 := Spaceship new.
	finishLine := 20.
	aGame := aGameBuilder
					addSpaceship: aSpaceship1;
		         addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: finishLine andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: finishLine);
		         build.

	aGame playTurn.

	self assert: aGame hasFinished.
	self assert: (aSpaceship1 isAtPosition: finishLine).
	self assert: (aSpaceship2 isAtPosition: 0)
]

{ #category : 'tests' }
GameTest >> testWhenASpaceshipReachesTheFinishLineTheGameEnds [

	| aGame aSpaceship aGameBuilder |
	

	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: 20);
		         build.

	aGame playTurn.
	self assert: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> testWhenGameCreatedItDoesntFinish [

	| aGame  aGameBuilder |
	
	aGameBuilder := GameBuilder new.
	aGame := aGameBuilder
		         addSpaceship: Spaceship new;
		         addBoard: (Board withSize: 6 andWormholeFrom: 2 to: 5);
				   addDice: (FixedDice onFace: 4);
		         build.
	
	self deny: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> testWhenLandingOnAWormholeConnectedToTheFinishLineTheGameEnds [

		| aGame aSpaceship aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 20);
		         addDice: (FixedDice onFace: 4);
		         build.

	aGame playTurn.

	self assert: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> testWhenTheSpaceshipMovesBeyondTheFinishLineTheGameEnds [

	| aGame aSpaceship aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: 25);
		         build.

	aGame playTurn.

	self assert: aGame hasFinished.
]

{ #category : 'tests' }
GameTest >> testWhenTheSpaceshipMovesWithTwoDicesBeyondTheFinishLineTheGameEnds [

	| aGame aSpaceship aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: 11);
					addDice: (FixedDice onFace: 10);
		         build.

	aGame playTurn.

	self assert: aGame hasFinished
]
