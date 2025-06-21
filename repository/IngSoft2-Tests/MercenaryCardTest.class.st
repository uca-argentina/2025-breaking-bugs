Class {
	#name : 'MercenaryCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MercenaryCardTest >> testIsInvalidIfASpashipThatUseMercenaryCardWantsToHaveHimselfAsMercenary [

	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard |
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (VelocityCard new)).
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
				   addSpaceship: aSpaceship2;
				   addSpaceship: aSpaceship3;
		         addBoard: (Board withSize: 90 andWormholeFrom: 49 to: 67);
		         addDice: (SequentialFixedDice onFaces: #(4 2));
		         build.

	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship.
	self assert: (aSpaceship getMercenaries size) equals: 0.
	self assert: (aSpaceship getCards size) equals: 2.
	
]

{ #category : 'tests' }
MercenaryCardTest >> testIsValidIfASpashipThatUseMercenaryCardHasAShaceshipAsMercenary [

	| aGameBuilder aSpaceship aSpaceship2 aGame aCard|
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (VelocityCard new)).
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
				   addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 8);
		         build.

	self assert: aSpaceship getCards size equals: 2.
	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aSpaceship getCards size) equals: 1.
	self assert: (aSpaceship2 getCards size) equals: 2.
	self assert: (aSpaceship numberOfMercenaries) equals: 1.
]

{ #category : 'tests' }
MercenaryCardTest >> testIsValidIfASpashipThatUseMercenaryCardHasAShaceshipThatHeSpecifiesAsMercenary [

	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard |
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (VelocityCard new)).
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
				   addSpaceship: aSpaceship2;
				   addSpaceship: aSpaceship3;
		         addBoard: (Board withSize: 90 andWormholeFrom: 49 to: 67);
		         addDice: (SequentialFixedDice onFaces: #(4 2 6 6 10 4 "batalla" 22 2 23));
		         build.

	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aSpaceship getMercenaries) equals: (OrderedCollection with: aSpaceship2).
	aGame playRound.
	self assert: aSpaceship2 getPosition equals: 12.
	self assert: aSpaceship3 getPosition equals: 0.
	self assert: aSpaceship getPosition equals: 10.
	
]
