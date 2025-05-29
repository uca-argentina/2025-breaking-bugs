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
GameTest >> testFullGameSimulationWithEffectsAndWinner [

	| aGame aSpaceship1 aSpaceship2 aBoard aGameBuilder finishLine aSpaceship3 aSpaceship4 aTileBuilder aTileCollection |
	aGameBuilder := GameBuilder new.
	aSpaceship1 := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	aSpaceship4 := Spaceship new.
	finishLine := 25.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder
		with: BlackHole new at: 9;
		with: AtomicBomb new at: 3;
		with: (HyperJump withDescendingParsecsFrom: 30 step: 10) at: 10;
		with: (MoonWalk for: 1) at: 20;
		with: HyperSpaceJump new at: 16.

	aTileCollection := aTileBuilder build.
	aBoard := Board
		          withSize: finishLine
		          andWormholeFrom: 4
		          to: 15
		          and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship1;
		         addSpaceship: aSpaceship2;
		         addSpaceship: aSpaceship3;
		         addSpaceship: aSpaceship4;
		         addBoard: aBoard;
		         addDice: (SequentialFixedDice onFaces: #( 2 7 8 14 18 50 ));
		         addDice: (FixedDice onFace: 1);
		         setLapsToWinTo: 2;
		         build.

	aGame playRound.



	self assert: (aSpaceship1 isAtPosition: 1).
	self assert: (aSpaceship2 isAtPosition: 5).
	self assert: (aSpaceship3 isAtPosition: 0).
	self assert: (aSpaceship4 isAtPosition: 20).

	aGame playRound.

	self assert: (aSpaceship1 isAtPosition: 20).
	self assert: (aSpaceship2 isAtPosition: finishLine).
	self assert: (aSpaceship3 isAtPosition: 24).
	self assert: (aSpaceship4 isAtPosition: 19).

	self assert: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> testFullGameSimulationWithWinner [

	| aGame aSpaceship1 aSpaceship2  aGameBuilder finishLine |
	aGameBuilder := GameBuilder new.
	aSpaceship1 := Spaceship new.
	aSpaceship2 := Spaceship new.
	finishLine := 19.
	aGame := aGameBuilder
					addSpaceship: aSpaceship1;
		         addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: finishLine andWormholeFrom: 4 to: 15);
					addDice: (SequentialFixedDice onFaces: #(3 7));
					addDice: (FixedDice onFace: 1);
		         build.

	aGame playRound.
	aGame playRound.

	
	self assert: (aSpaceship1 isAtPosition: finishLine).
	self assert: (aSpaceship2 isAtPosition: 8).
	self assert: aGame hasFinished.
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

	aGame playRound.
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

	aGame playRound.
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

	aGame playRound.
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

	aGame playRound.
	self
		should: [ aGame playRound. ]
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

	aGame playRound.

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

	aGame playRound.
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

	aGame playRound.

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

	aGame playRound.

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

	aGame playRound.

	self assert: aGame hasFinished
]
