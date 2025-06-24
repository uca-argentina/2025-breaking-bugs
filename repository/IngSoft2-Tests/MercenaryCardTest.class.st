Class {
	#name : 'MercenaryCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MercenaryCardTest >> testInvalidWhenSpaceshipTriesToHireASpaceshipThatIsAlreadyAMercenarys [

	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard |
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
				   addSpaceship: aSpaceship2;
				   addSpaceship: aSpaceship3;
		         addBoard: (Board withSize: 90 andWormholeFrom: 49 to: 67);
		         addDice: (SequentialFixedDice onFaces: #(4 2 6 6 10 4 ));
		         build.

	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aGame getMercenariesOf: aSpaceship) equals: (OrderedCollection with: aSpaceship2).
	
	aGame playRoundUsing: aCard of: aSpaceship3 to: aSpaceship2.
	self deny: (aGame getMercenariesOf: aSpaceship3) equals: (OrderedCollection with: aSpaceship2 ).
	self assert: (aGame getMercenariesOf: aSpaceship3)size equals: 0.
]

{ #category : 'tests' }
MercenaryCardTest >> testIsInvalidIfASpashipThatUseMercenaryCardWantsToHaveHimselfAsMercenary [

	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard |
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (SpeedCard new)).
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
MercenaryCardTest >> testIsValidIfASpaceship [

	| aGameBuilder aSpaceship aSpaceship2 aGame aCard|
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aSpaceship2 := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
				   addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 8);
		         build.
		
	
	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aGame getMercenariesOf: aSpaceship)size equals: 1.
	self assert: (aGame getMercenariesOf: aSpaceship2)size equals: 0.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 1.
	self assert: (aGame getCardsOf: aSpaceship2)size equals: 2.
]

{ #category : 'tests' }
MercenaryCardTest >> testIsValidIfASpaceshipThatUseMercenaryCardHastwoSpaceshipsThatHeSpecifiesAsMercenaries [ 

	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard |
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
				   addSpaceship: aSpaceship2;
				   addSpaceship: aSpaceship3;
		         addBoard: (Board withSize: 90 andWormholeFrom: 49 to: 67);
		         addDice: (SequentialFixedDice onFaces: #(4 2 6 6 10 4 ));
		         build.

	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aGame getMercenariesOf: aSpaceship) equals: (OrderedCollection with: aSpaceship2).
	
	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship3.
	self assert: (aGame getMercenariesOf: aSpaceship) equals: (OrderedCollection with: aSpaceship2 with: aSpaceship3).
	self assert: (aGame getPositionOf: aSpaceship) equals: 10.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 12.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 10.
	
]

{ #category : 'tests' }
MercenaryCardTest >> testIsValidIfASpashipThatUseMercenaryCardHasAShaceshipThatHeSpecifiesAsMercenary [ 

	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard |
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (SpeedCard new)).
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
	self assert: (aGame getMercenariesOf: aSpaceship) equals: (OrderedCollection with: aSpaceship2).
	aGame playRound.
	self assert: (aGame getPositionOf: aSpaceship) equals: 10.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 12.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 0.
	
	
]

{ #category : 'tests' }
MercenaryCardTest >> testIsValidIfNoBattleOccursWhenSpaceshipAndMercenaryLandOnSameTile [ 


	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard |
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (SpeedCard new)).
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
				   addSpaceship: aSpaceship2;
				   addSpaceship: aSpaceship3;
		         addBoard: (Board withSize: 90 andWormholeFrom: 49 to: 67);
		         addDice: (SequentialFixedDice onFaces: #(4 2 3 2 4 10));
		         build.

	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aSpaceship getMercenaries size) equals: 1.
	self assert: (aSpaceship getCards size) equals: 1.
	
	aGame playRound.
	self assert: (aGame getPositionOf: aSpaceship) equals: 6.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 6.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 13.
	
]

{ #category : 'tests' }
MercenaryCardTest >> testWhenASpaceshipAndHisMercenaryLoseABattleThenBothLoseAShield [

	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard |
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: aCard).
	aSpaceship2 := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
				   addSpaceship: aSpaceship2;
					addSpaceship: aSpaceship3;

		         addBoard: (Board withSize: 90 andWormholeFrom: 49 to: 67);
		         addDice: (SequentialFixedDice onFaces: #(4 19 4 "batalla" 5 1 3 ));
		         build.

	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aGame getMercenariesOf: aSpaceship) equals: (OrderedCollection with: aSpaceship2).
	self assert: (aGame getPositionOf: aSpaceship) equals: 0.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 19.
	
	self assert: (aGame getShieldsOf: aSpaceship) equals: 2.
	self assert: (((aGame getMercenariesOf: aSpaceship) at:1)getShields) equals: 2.
	
]

{ #category : 'tests' }
MercenaryCardTest >> testisvalidIfASpaceshipCannotHireSameMercenaryTwiceEvenWithTwoCards [ 

	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard |
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
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
	self assert: (aGame getMercenariesOf: aSpaceship) equals: (OrderedCollection with: aSpaceship2).
	
	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aGame getMercenariesOf: aSpaceship) equals: (OrderedCollection with: aSpaceship2).
	self assert: (aGame getCardsOf: aSpaceship)size equals: 1.
	
]
