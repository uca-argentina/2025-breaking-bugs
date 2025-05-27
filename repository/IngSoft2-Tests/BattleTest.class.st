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
BattleTest >> testSpaceshipsBattleWhenLandingOnSamePositionAndLoserIsPenalized [

	| aGameBuilder aSpaceship anOponent aGame |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	anOponent := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
					addSpaceship: anOponent;
		         addBoard: (CircularBoard withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (SequentialFixedDice onFaces: #(4 4 14 12));
		         build.

	aGame playRound.
	self assert: aSpaceship getPosition equals: 9.
	self assert: aSpaceship getShields equals: 3.
	self assert: anOponent getPosition equals: 0.
	self assert: anOponent getShields equals: 2.
]
