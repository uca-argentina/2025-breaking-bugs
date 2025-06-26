Class {
	#name : 'RedoCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RedoCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
RedoCardTest >> testRedoCardAfterRepeatOfBlackHoleReappliesOriginalEffect [

	| gameBuilder boardBuilder board dice spaceship repeatCard redoCard game |
	repeatCard := RepeatCard new.
	redoCard := RedoCard new.
	spaceship := Spaceship with:
		             (OrderedCollection with: repeatCard with: redoCard).
	boardBuilder := TilesBuilder with: 90.
	boardBuilder with: BlackHole new at: 4.
	board := Board
		         withSize: 90
		         andWormholeFrom: 80
		         to: 89
		         and: boardBuilder build.
	dice := SequentialFixedDice onFaces: { 4. 5. 5 }.
	gameBuilder := GameBuilder new.
	game := gameBuilder
		        addSpaceship: spaceship;
		        addBoard: board;
		        addDice: dice;
		        build.

	game playRound.
	self assert: (game getPositionOf: spaceship) equals: 0.
	game playRound.
	game playInstant: repeatCard of: spaceship to: spaceship.
	self assert: (game getPositionOf: spaceship) equals: 1.
	game playRound.
	self assert: (game getPositionOf: spaceship) equals: 6.
	game playInstant: redoCard of: spaceship to: spaceship.

	self assert: (game getPositionOf: spaceship) equals: 2.
]

{ #category : 'tests' }
RedoCardTest >> testRedoCardAfterRepeatOfHyperJumpReappliesOriginalEffect [

	| gameBuilder boardBuilder board dice spaceship1 spaceship2 spaceship3 repeatCard redoCard game |
	repeatCard := RepeatCard new.
	redoCard := RedoCard new.

	spaceship1 := Spaceship with:
		              (OrderedCollection with: repeatCard with: redoCard).
	spaceship2 := Spaceship new.
	spaceship3 := Spaceship new.

	"Tablero con HyperJump (30,20,10 pársecs) en casillero 4"
	boardBuilder := (TilesBuilder with: 90)
		                with:
		                (HyperJump withDescendingParsecsFrom: 30 step: 10)
		                at: 4.
	board := Board
		         withSize: 90
		         andWormholeFrom: 80
		         to: 89
		         and: boardBuilder build.

	dice := FixedDice onFace: 4.
	gameBuilder := GameBuilder new.
	game := gameBuilder
		        addSpaceship: spaceship1;
		        addSpaceship: spaceship2;
		        addSpaceship: spaceship3;
		        addBoard: board;
		        addDice: dice;
		        build.

	game playRound.

	self assert: (game getPositionOf: spaceship1) equals: 19. 
	self assert: (game getPositionOf: spaceship2) equals: 14. 
	self assert: (game getPositionOf: spaceship3) equals: 9. 

	
	game playInstant: repeatCard of: spaceship1 to: spaceship2.
	self assert: (game getPositionOf: spaceship1) equals: 19.
	self assert: (game getPositionOf: spaceship2) equals: 29.
	self assert: (game getPositionOf: spaceship3) equals: 9.

	game playInstant: redoCard of: spaceship1 to: spaceship2.
	self assert: (game getPositionOf: spaceship1) equals: 19.
	self assert: (game getPositionOf: spaceship2) equals: 39.
	self assert: (game getPositionOf: spaceship3) equals: 9.
]

{ #category : 'tests' }
RedoCardTest >> testWhenUsingARedoCardAfterUsingACancellationCardThenTheFirstActivePermanentCardIsCancelled [

	| aGame aSpaceship aGameBuilder position1 aSpeedCard aRedoCard anotherSpeedCard aCancellationCard lastCard |
	position1 := 6.
	aGameBuilder := GameBuilder new.
	aSpeedCard := SpeedCard new.
	anotherSpeedCard := SpeedCard new.
	aCancellationCard := CancelationCard new.
	aRedoCard := RedoCard new.
	aSpaceship := Spaceship with:
		              (OrderedCollection with: aSpeedCard with: aRedoCard with: aCancellationCard with: anotherSpeedCard ).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
		         addDice: (FixedDice onFace: position1);
		         build.

	aGame playRoundUsing: aSpeedCard of: aSpaceship.
	aGame playRoundUsing: anotherSpeedCard of: aSpaceship.
	aGame playInstant: aCancellationCard of: aSpaceship on: aSpeedCard.
	lastCard := aGame lastCardThrown.
	aGame playInstant: aRedoCard of: aSpaceship to: nil.
	aGame playRound.

	self
		assert: (aGame getPositionOf: aSpaceship)
		equals: position1 * 3 + 1.
]

{ #category : 'tests' }
RedoCardTest >> testWhenUsingARedoCardAfterUsingAMercenaryCardThenTheSpaceshipHas2Mercenaries [

	| aGame aSpaceship aSpaceship2 aSpaceship3 aGameBuilder position1 aMercenaryCard aRedoCard |
	position1 := 6.
	aGameBuilder := GameBuilder new.
	aMercenaryCard := MercenaryCard new.
	aRedoCard := RedoCard new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	aSpaceship := Spaceship with:
		              (OrderedCollection
			               with: aMercenaryCard
			               with: aRedoCard).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
					addSpaceship: aSpaceship3;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
		         addDice: (FixedDice onFace: position1);
		         build.

	aGame playRoundUsing: aMercenaryCard of: aSpaceship to: aSpaceship2.
	aGame playRoundUsing: aRedoCard of: aSpaceship to: aSpaceship3.

	self assert: (aGame getMercenariesOf: aSpaceship) equals: (OrderedCollection with: aSpaceship2 with: aSpaceship3).
]

{ #category : 'tests' }
RedoCardTest >> testWhenUsingARedoCardAfterUsingARedoCardThenTheFirstEffectIsReapplied [

	| aGame aSpaceship aGameBuilder position1 aSpeedCard aRedoCard anotherRedoCard |
	position1 := 6.
	aGameBuilder := GameBuilder new.
	aSpeedCard := SpeedCard new.
	aRedoCard := RedoCard new.
	anotherRedoCard := RedoCard new.
	aSpaceship := Spaceship with:
		              (OrderedCollection
			               with: aSpeedCard
			               with: aRedoCard
			               with: aRedoCard).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
		         addDice: (FixedDice onFace: position1);
		         build.

	aGame playRoundUsing: aSpeedCard of: aSpaceship.
	aGame playRoundUsing: aRedoCard of: aSpaceship.
	aGame playRoundUsing: anotherRedoCard of: aSpaceship.
	aGame playRound.

	self
		assert: (aGame getPositionOf: aSpaceship)
		equals: position1 * 4 + 6
]

{ #category : 'tests' }
RedoCardTest >> testWhenUsingARedoCardAfterUsingASpeedCardThenTheSpaceshipDoublesItsSpeed [

	| aGame aSpaceship aGameBuilder position1 aSpeedCard aRedoCard |
	position1 := 6.
	aGameBuilder := GameBuilder new.
	aSpeedCard := SpeedCard new.
	aRedoCard := RedoCard new.
	aSpaceship := Spaceship with:
		              (OrderedCollection with: aSpeedCard with: aRedoCard).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
		         addDice: (FixedDice onFace: position1);
		         build.

	aGame playRoundUsing: aSpeedCard of: aSpaceship.
	aGame playRoundUsing: aRedoCard of: aSpaceship.
	aGame playRound.

	self
		assert: (aGame getPositionOf: aSpaceship)
		equals: position1 * 3 + 3
]

{ #category : 'tests' }
RedoCardTest >> testWhenUsingARedoCardAfterUsingAnAccelerationCardThenAllSpaceshipsDoubleItsSpeed [

	| aGame aSpaceship aSpaceship2 aGameBuilder position1 position2 anAccelerationCard aRedoCard |
	position1 := 6.
	position2 := 4.
	aGameBuilder := GameBuilder new.
	anAccelerationCard := AccelerationCard new.
	aRedoCard := RedoCard new.
	aSpaceship := Spaceship with:
		              (OrderedCollection
			               with: anAccelerationCard
			               with: aRedoCard).
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
		         addDice: (SequentialFixedDice onFaces: {
						          position1.
						          position2 });
		         build.

	aGame playRoundUsing: anAccelerationCard of: aSpaceship.
	aGame playRoundUsing: aRedoCard of: aSpaceship.
	aGame playRound.

	self
		assert: (aGame getPositionOf: aSpaceship)
		equals: position1 * 3 + 3.

	self
		assert: (aGame getPositionOf: aSpaceship2)
		equals: position2 * 3 + 5
]

{ #category : 'tests' }
RedoCardTest >> testWhenUsingARedoCardHavingNotUsedOtherBeforeThenError [

	| aGame aSpaceship aGameBuilder position1 aRedoCard |
	position1 := 6.
	aGameBuilder := GameBuilder new.
	aRedoCard := RedoCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: aRedoCard).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
		         addDice: (FixedDice onFace: position1);
		         build.
	
	self
		should: [ aGame playRoundUsing: aRedoCard of: aSpaceship. ]
		raise: Error
		withMessageText: 'The way the redo card was implemented is not correct'
]
