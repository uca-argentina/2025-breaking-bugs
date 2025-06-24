Class {
	#name : 'CancelationCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CancelationCardTest >> should: test raise: aErrorClass withMessageError: aMessage [ 
	self 
		should: test
		raise: aErrorClass 
		withExceptionDo:  [: error | self assert: (error messageText) equals: aMessage].
]

{ #category : 'tests' }
CancelationCardTest >> testIsValidIfACancelationCardAppliesEffectCorrectlyToAnAffectedSpaceshipAndConsumesCard [

	| aGame aSpaceship aGameBuilder position1 position2 anInstantCard aSpaceship2 aPermanentCard |
	position1 := 6.
	position2 := 4.
	aGameBuilder := GameBuilder new.
	anInstantCard := CancelationCard new.
	aPermanentCard := SpeedCard new.
	aSpaceship := Spaceship with:
		              (OrderedCollection
			               with: aPermanentCard
			               with: anInstantCard).
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
		         addDice: (SequentialFixedDice onFaces: {
						          position1.
						          position2 });
		         build.

	aGame playRoundUsing: aPermanentCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship) size equals: 1.
	self assert: (aGame getCardsOf: aSpaceship2) size equals: 2.

	self assert: (aGame getPositionOf: aSpaceship) equals: position1.
	self assert: (aGame getPositionOf: aSpaceship2) equals: position2.

	aGame play: anInstantCard of: aSpaceship on: aPermanentCard.

	aGame playRound.

	self assert: (aGame getPositionOf: aSpaceship) equals: position1 * 2.
	self assert: (aGame getPositionOf: aSpaceship2) equals: position2 * 2
]

{ #category : 'tests' }
CancelationCardTest >> testWhenCancelationCardPlayedThenMercenaryEffectIsReverted [

	| aGame aSpaceship aSpaceship2 aSpaceship3 aGameBuilder position1 position2 anInstantCard aPermanentCard |
	position1 := 6.
	position2 := 4.
	aGameBuilder := GameBuilder new.
	anInstantCard := CancelationCard new.
	aPermanentCard := MercenaryCard new.
	aSpaceship := Spaceship with:
		              (OrderedCollection
			               with: aPermanentCard
			               with: anInstantCard).
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
					addSpaceship: aSpaceship3;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
		         addDice: (SequentialFixedDice onFaces: {
						          position1.
						          position2 });
		         build.

	aGame playRoundUsing: aPermanentCard of: aSpaceship to: aSpaceship2.

	self assert: (aGame getCardsOf: aSpaceship) size equals: 1.
	self assert: (aGame getCardsOf: aSpaceship2) size equals: 2.

	self assert: (aGame getMercenariesOf: aSpaceship) size equals: 1.

	aGame play: anInstantCard of: aSpaceship with: aPermanentCard to: aSpaceship2.

	aGame playRound.

	self assert: aSpaceship getMercenaries size equals: 0.
	self assert: aSpaceship2 getMercenaries size equals: 0
]

{ #category : 'tests' }
CancelationCardTest >> testWhenTryingToCancelACardThatIsNotActiveThenItIsNotPossible [

	| aGame aSpaceship aGameBuilder aCancellationCard anAccelerationCard |
	aGameBuilder := GameBuilder new.
	aCancellationCard := CancelationCard new.
	anAccelerationCard := AccelerationCard new.
	aSpaceship := Spaceship with:
		              (OrderedCollection with: aCancellationCard).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
		         addDice: (FixedDice onFace: 4);
		         build.

	self
		should: [
		aGame play: aCancellationCard of: aSpaceship on: anAccelerationCard ]
		raise: Error
		withMessageError: 'The card wanted is not active'
]

{ #category : 'tests' }
CancelationCardTest >> testWhenUsingARedoCardAfterUsingASpeedCardThenTheSpaceshipDoublesItsSpeed [

	| aGame aSpaceship aGameBuilder position1 position2 anInstantCard aSpaceship2 aPermanentCard |
	position1 := 6.
	position2 := 4.
	aGameBuilder := GameBuilder new.
	anInstantCard := CancelationCard new.
	aPermanentCard := AccelerationCard new.
	aSpaceship := Spaceship with:
		              (OrderedCollection
			               with: aPermanentCard
			               with: anInstantCard).
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
		         addDice: (SequentialFixedDice onFaces: {
						          position1.
						          position2 });
		         build.

	aGame playRoundUsing: aPermanentCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship) size equals: 1.
	self assert: (aGame getCardsOf: aSpaceship2) size equals: 2.

	aGame play: anInstantCard of: aSpaceship on: aPermanentCard.

	aGame playRound.

	self assert: (aGame getPositionOf: aSpaceship) equals: position1 * 2.
	self
		assert: (aGame getPositionOf: aSpaceship2)
		equals: position2 * 2 + 1
]
