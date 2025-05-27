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

	| aGameBuilder aSpaceship aSpaceship2 aSecondOponent aGame |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSecondOponent := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
		         addBoard: (CircularBoard withSize: 40 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #(4 4 12 14 ));
		         build.

	aGame playRound.
	self assert: aSpaceship2 getPosition equals: 0.
	self assert: aSpaceship2 getShields equals: 2.
	aGame playRound.
	aGame playRoundSkipping: {aSpaceship2}.
	self assert: aSpaceship2 getPosition equals: 9.
	self assert: aSpaceship2 getShields equals: 3.
	
]

{ #category : 'tests' }
BattleTest >> testSpaceshipRecoversShieldsAfterSkippingTurn [

	| aGameBuilder aSpaceship aSpaceship2 aSecondOponent aGame |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSecondOponent := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
		         addBoard: (CircularBoard withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #(4 4 12 14 ));
		         build.

	aGame playRound.
	self assert: aSpaceship2 getPosition equals: 0.
	self assert: aSpaceship2 getShields equals: 2.
	aGame playRoundSkipping: {aSpaceship2}.
	self assert: aSpaceship2 getPosition equals: 0.
	self assert: aSpaceship2 getShields equals: 3.
	
]

{ #category : 'tests' }
BattleTest >> testSpaceshipsBattleWhenLandingOnSamePositionAndLoserIsPenalized [

	| aGameBuilder aSpaceship aSpaceship2 aGame |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
		         addBoard: (CircularBoard withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #(4 4 12 14));
		         build.

	aGame playRound.
	self assert: aSpaceship getPosition equals: 9.
	self assert: aSpaceship getShields equals: 3.
	self assert: aSpaceship2 getPosition equals: 0.
	self assert: aSpaceship2 getShields equals: 2.
]

{ #category : 'tests' }
BattleTest >> testWhenTwoSpaceshipsLandOnSamePositionThenLoserReturnsToStartAndLosesShield [

	| aGameBuilder aSpaceship aSpaceship2 aSecondOponent aGame |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSecondOponent := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: aSpaceship2;
		         addBoard: (CircularBoard withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #(4 4 12 14 ));
		         build.

	aGame playRound.
	self assert: aSpaceship getPosition equals: 9.
	self assert: aSpaceship getShields equals: 3.
	self assert: aSpaceship2 getPosition equals: 0.
	self assert: aSpaceship2 getShields equals: 2.
]
