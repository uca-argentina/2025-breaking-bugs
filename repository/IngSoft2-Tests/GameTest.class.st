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
GameTest >> testAllTheEffectsOnGame [
	| game aSpaceship1 aSpaceship2 aSpaceship3 aSpaceship4 board gameBuilder finishLine tileBuilder tileCollection |

	gameBuilder := GameBuilder new.
	aSpaceship1 := Spaceship new. aSpaceship2 := Spaceship new. aSpaceship3 := Spaceship new. aSpaceship4 := Spaceship new.
	finishLine := 25.

	tileBuilder := TilesBuilder with: finishLine.
	tileBuilder
		with: AtomicBomb new at: 3;
		with: BlackHole new at: 9;
		with: (HyperJump withDescendingParsecsFrom: 30 step: 10) at: 10;
		with: (MoonWalk for: 2) at: 19;
		with: HyperSpaceJump new at: 16.

	tileCollection := tileBuilder build.

	board := Board withSize: finishLine andWormholeFrom: 4 to: 15 and: tileCollection.

	game := gameBuilder
		addSpaceship: aSpaceship1; addSpaceship: aSpaceship2; addSpaceship: aSpaceship3; addSpaceship: aSpaceship4;
		addBoard: board;
		addDice: (SequentialFixedDice onFaces: #(3 9 5 4 10 11 14 4));
		setLapsToWinTo: 2;
		build.

	"Ronda 1"
	game playRound.

	self assert: (game getPositionOf: aSpaceship1) equals: 0.
	self assert: (game getPositionOf: aSpaceship2) equals: 5.
	self assert: (game getPositionOf: aSpaceship3) equals: 5.
	self assert: (game getPositionOf: aSpaceship4) equals: 15.

	"Ronda 2"
	game playRound.
	
	self assert: (game getPositionOf: aSpaceship1) equals: 23. "Pisa HyperJump → avanza 10 parsecs"
	self assert: (game getPositionOf: aSpaceship2) equals: 18. "Pisa HyperSpaceJump → avanza 4"
	self assert: (game getPositionOf: aSpaceship3) equals: 19. "MoonWalk, pero no retrocede"
	self assert: (game getPositionOf: aSpaceship4) equals: 17. "Retrocedido por MoonWalk (estaba en 4)"
	
	self assert: (game getShieldsOf: aSpaceship1) equals: 2.
	self assert: (game getShieldsOf: aSpaceship2) equals: 1.
	self assert: (game getShieldsOf: aSpaceship3) equals: 2.
	self assert: (game getShieldsOf: aSpaceship4) equals: 2.
	
	

]

{ #category : 'tests' }
GameTest >> testFullGameSimulationWithEffectsAndWinner [

	| aGame aSpaceship1 aSpaceship2 aBoard aGameBuilder finishLine aSpaceship3 aSpaceship4 aTileBuilder aTileCollection aPositionTable |
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
		with: (MoonWalk for: 1) at: 19;
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
		         addDice: (SequentialFixedDice onFaces: #( 2 7 8 14 18 100 ));
		         addDice: (FixedDice onFace: 1);
		         setLapsToWinTo: 2;
		         build.

	aGame playRound.



	self assert: (aGame getPositionOf: aSpaceship1) equals: 0.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 8.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 5.
	self assert: (aGame getPositionOf: aSpaceship4) equals: 4.
	
	self assert: (aGame getShieldsOf: aSpaceship1) equals: 2.
	self assert: (aGame getShieldsOf: aSpaceship2) equals: 2.
	self assert: (aGame getShieldsOf: aSpaceship3) equals: 2.
	self assert: (aGame getShieldsOf: aSpaceship4) equals: 2.
	self deny: aGame hasFinished.

	aGame playRound.
	self assert: aGame hasFinished.
	aPositionTable := (aGame getPositionTable).
	self assert: (aPositionTable isWinner: aSpaceship2).
	self deny: (aPositionTable isWinner: aSpaceship1).
	self deny: (aPositionTable isWinner: aSpaceship3).
	self deny: (aPositionTable isWinner: aSpaceship4).
	
	self assert: (aGame getPositionOf: aSpaceship1) equals: 19.
	self assert: (aGame getPositionOf: aSpaceship2) equals: finishLine.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 4.
	self assert: (aGame getPositionOf: aSpaceship4) equals: 3.

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

	
	self assert: (aGame getPositionOf: aSpaceship1) equals: finishLine.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 8.
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
	self assert: (aGame getPositionOf: aSpaceship) equals: 5.
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
	self assert: (aGame getPositionOf: aSpaceship) equals: 9.
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
	self assert: (aGame getPositionOf: aSpaceship) equals: 4.
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
	
	self assert: (aGame getPositionOf: aSpaceship1) equals: finishLine.
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
