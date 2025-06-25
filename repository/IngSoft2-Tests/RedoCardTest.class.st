Class {
	#name : 'RedoCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RedoCardTest >> testWhenUsingARedoCardAfterUsingACancellationCardThenTheFirstActivePermanentCardIsCancelled [

	| aGame aSpaceship aGameBuilder position1 aSpeedCard anotherSpeedCard aCancellationCard aRedoCard |
	position1 := 6.
	aGameBuilder := GameBuilder new.
	aSpeedCard := SpeedCard new.
	anotherSpeedCard := SpeedCard new.
	aCancellationCard := CancelationCard new.
	aRedoCard := RedoCard new.
	aSpaceship := Spaceship with: (OrderedCollection
			               with: aSpeedCard
			               with: anotherSpeedCard
			               with: aCancellationCard
			               with: aRedoCard).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
		         addDice: (FixedDice onFace: position1);
		         build.

	aGame playRoundUsing: aSpeedCard of: aSpaceship.
	aGame playRoundUsing: anotherSpeedCard of: aSpaceship.
	aGame play: aCancellationCard of: aSpaceship on: aSpeedCard.
	"self assert: aGame numberOfActivePermanentCards equals: 1."
	aGame playRoundUsing: aRedoCard of: aSpaceship.

	self assert: aGame numberOfActivePermanentCards equals: 0.
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
RedoCardTest >> testWhenUsingARedoCardHavingNotUsedOtherBeforeThenNothingHappens [

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

	aGame playRoundUsing: aRedoCard of: aSpaceship.
	aGame playRound.

	self assert: (aGame getPositionOf: aSpaceship) equals: position1 * 2
]
