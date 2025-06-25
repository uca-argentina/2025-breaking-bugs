Class {
	#name : 'BattleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BattleTest >> testIsValidIfSpaceshipHasThreeShieldsWhenCreated [

| aSpaceship |
	aSpaceship := Spaceship new.
self assert: aSpaceship getShields equals: 3.
]

{ #category : 'tests' }
BattleTest >> testPenalizedSpaceshipMovesAndThenRecoversShieldsAfterSkipTurn [

	| aGameBuilder aSpaceship aSpaceship2 aSecondOponent aGame getter |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSecondOponent := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 40 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #(4 4 12 14 ));
		         build.

	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship2) equals: 0.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 2.
	aGame playRound.
	"self assert: (aGame getPositionOf: aSpaceship2) equals: 4."
	aGame playRoundSkipping: {aSpaceship2}.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship2) equals: 9.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 3.
	
]

{ #category : 'tests' }
BattleTest >> testSpaceshipRecoversAfterTwoPenaltyRoundsAndResumesMovementWithShields [

	| aGameBuilder aSpaceship aSpaceship2 aGame getter |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #("turn"2 2 "battle"10 12 "turn"1 3 "battle"10 12 "turn"2 5 "battle"10 12 "turn"1 "turn"1 "turn"2 4));
		         build.

	aGame playRound.
	aGame playRound.
	aGame playRound.
	aGame playRound. "Se queda sin escudos por lo cual no va a poder moverse"
	aGame playRound. "Se queda sin escudos por lo cual no va a poder moverse"
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship2) equals: 0.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 3.
	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship2) equals: 9.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 3.
	
	
]

{ #category : 'tests' }
BattleTest >> testSpaceshipRecoversShieldsAfterSkippingTurn [

	| aGameBuilder aSpaceship aSpaceship2 aSecondOponent aGame getter |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSecondOponent := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #(4 4 12 14 ));
		         build.

	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship2) equals: 0.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 2.
	aGame playRoundSkipping: {aSpaceship2}.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship2) equals: 0.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 3.
	
]

{ #category : 'tests' }
BattleTest >> testSpaceshipWithNoShieldsCannotMoveDuringPenalty [

	| aGameBuilder aSpaceship aSpaceship2 aGame getter|
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #("turn"2 2 "battle"10 12 "turn"1 3 "battle"10 12 "turn"2 5 "battle"10 12 "turn"4 2));
		         build.

	aGame playRound.
	aGame playRound.
	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship2) equals: 0.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 0.
	aGame playRound. "Se queda sin escudos por lo cual no va a poder moverse"
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship2) equals: 0.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 0.
	
]

{ #category : 'tests' }
BattleTest >> testSpaceshipsBattleWhenLandingOnSamePositionAndLoserIsPenalized [

	| aGameBuilder aSpaceship aSpaceship2 aGame getter|
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #(4 4 12 14));
		         build.

	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship) equals: 9.
	self assert: (getter getShieldsOf: aSpaceship) equals: 3.
	self assert: (getter getPositionOf: aSpaceship2) equals: 0.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 2.
]

{ #category : 'tests' }
BattleTest >> testWhenBattleIsTiedThenSpaceshipAlreadyOnTileWins [

	| aGameBuilder aSpaceship aSpaceship2 aSecondOponent aGame getter|
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSecondOponent := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #(4 4 4 4 ));
		         build.

	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship) equals: 9.
	self assert: (getter getShieldsOf: aSpaceship) equals: 3.
	self assert: (getter getPositionOf: aSpaceship2) equals: 0.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 2.
]

{ #category : 'tests' }
BattleTest >> testWhenTwoSpaceshipsLandOnSamePositionThenLoserReturnsToStartAndLosesShield [

	| aGameBuilder aSpaceship aSpaceship2 aSecondOponent aGame getter|
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSecondOponent := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #(4 4 12 14 ));
		         build.

	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship) equals: 9.
	self assert: (getter getShieldsOf: aSpaceship) equals: 3.
	self assert: (getter getPositionOf: aSpaceship2) equals: 0.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 2.
]
