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
	| game s1 s2 s3 s4 board gameBuilder finishLine tileBuilder tileCollection |

	gameBuilder := GameBuilder new.
	s1 := Spaceship new. s2 := Spaceship new. s3 := Spaceship new. s4 := Spaceship new.
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
		addSpaceship: s1; addSpaceship: s2; addSpaceship: s3; addSpaceship: s4;
		addBoard: board;
		addDice: (SequentialFixedDice onFaces: #(3 9 5 4 10 11 14 4));
		setLapsToWinTo: 2;
		build.

	"Ronda 1"
	game playRound.

	self assert: s1 getPosition equals: 0.  "AtomicBomb → todos a 0"
	self assert: s2 getPosition equals: 5.  "9 → BlackHole → 5"
	self assert: s3 getPosition equals: 5.
	self assert: s4 getPosition equals: 15.

	"Ronda 2"
	game playRound.

	self assert: s1 getPosition equals: 23. "Pisa HyperJump → avanza 10 parsecs"
	self assert: s2 getPosition equals: 18. "Pisa HyperSpaceJump → avanza 4"
	self assert: s3 getPosition equals: 19. "MoonWalk, pero no retrocede"
	self assert: s4 getPosition equals: 17.  "Retrocedido por MoonWalk (estaba en 4)"

	self assert: s1 getShields equals: 2.
	self assert: s2 getShields equals: 1. "Pierde 1 por HyperSpaceJump"
	self assert: s3 getShields equals: 2.
	self assert: s4 getShields equals: 2.

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
		         addDice: (SequentialFixedDice onFaces: #( 2 7 8 14 18 50 ));
		         addDice: (FixedDice onFace: 1);
		         setLapsToWinTo: 2;
		         build.

	aGame playRound.



	self assert: (aSpaceship1 getPosition) equals: 0.
	self assert: (aSpaceship2 getPosition) equals: 8.
	self assert: (aSpaceship3 getPosition) equals: 5.
	self assert: (aSpaceship4 getPosition) equals: 4.
	
	self assert: aSpaceship1 getShields equals: 2.
	self assert: aSpaceship2 getShields equals: 2.
	self assert: aSpaceship3 getShields equals: 2.
	self assert: aSpaceship4 getShields equals: 2.

	aGame playRound.

	self assert: (aSpaceship1 getPosition) equals: 19.
	self assert: (aSpaceship2 getPosition) equals: finishLine.
	self assert: (aSpaceship3 getPosition) equals: 4.
	self assert: (aSpaceship4 getPosition) equals: 3.

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
