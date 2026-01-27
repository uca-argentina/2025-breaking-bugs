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
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries equals: (OrderedCollection with: aSpaceship2).
	
	aGame playRoundUsing: aCard of: aSpaceship3 to: aSpaceship2.
	self deny: (aGame spaceshipMatching: aSpaceship3) getMercenaries equals: (OrderedCollection with: aSpaceship2 ).
	self assert: (aGame spaceshipMatching: aSpaceship2) getMercenaries size equals: 0.
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
MercenaryCardTest >> testIsInvalidIfSpaceshipCanPlayTwiceTheMercenaryCard [

	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard aSecondCard |
	aGameBuilder := GameBuilder new.
	aCard := MercenaryCard new.
	aSecondCard := SpeedCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: aCard with: aSecondCard).
	aSpaceship2 := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
				   addSpaceship: aSpaceship2;
					addSpaceship: aSpaceship3;

		         addBoard: (Board withSize: 90 andWormholeFrom: 49 to: 67);
		         addDice: (SequentialFixedDice onFaces: #(4 19 5 "batalla" 5 1 7 ));
		         build.

	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries equals: (OrderedCollection with: aSpaceship2).
	self assert: ((aGame spaceshipMatching: aSpaceship) getCards size) equals:  1.
	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: ((aGame spaceshipMatching: aSpaceship) getCards size) equals:  1.
	
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
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries size equals: 1.
	self assert: (aGame spaceshipMatching: aSpaceship2) getMercenaries size equals: 0.
	self assert: ((aGame spaceshipMatching: aSpaceship) getCards size) equals:  1.
	self assert: ((aGame spaceshipMatching: aSpaceship2) getCards size) equals:  2.
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
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries equals: (OrderedCollection with: aSpaceship2).
	
	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship3.
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries equals: (OrderedCollection with: aSpaceship2 with: aSpaceship3).
	self assert: (aGame spaceshipMatching: aSpaceship) getPosition equals: 10.
	self assert: (aGame spaceshipMatching: aSpaceship2) getPosition equals: 12.
	self assert: (aGame spaceshipMatching: aSpaceship3) getPosition equals: 10.
	
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
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries equals: (OrderedCollection with: aSpaceship2).
	aGame playRound.
	self assert: (aGame spaceshipMatching: aSpaceship) getPosition equals: 10.
	self assert: (aGame spaceshipMatching: aSpaceship2) getPosition equals: 12.
	self assert: (aGame spaceshipMatching: aSpaceship3) getPosition equals: 0.
	
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
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries equals: (OrderedCollection with: aSpaceship2).
	self assert: ((aGame spaceshipMatching: aSpaceship) getCards size) equals:  1.
	
	aGame playRound.
	self assert: (aGame spaceshipMatching: aSpaceship) getPosition equals: 6.
	self assert: (aGame spaceshipMatching: aSpaceship2) getPosition equals: 6.
	self assert: (aGame spaceshipMatching: aSpaceship3) getPosition equals: 13.
	
]

{ #category : 'tests' }
MercenaryCardTest >> testIsValidIfSpaceshipAndMercenaryWinsWhenSpaceshipOrMercenaryHasHighestDice [

	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard mercenary |
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
		         addDice: (SequentialFixedDice onFaces: #(4 19 4 "batalla" 5 1 7 ));
		         build.

	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries equals: (OrderedCollection with: aSpaceship2).
	self assert: (aGame spaceshipMatching: aSpaceship) getPosition equals: 4.
	self assert: (aGame spaceshipMatching: aSpaceship2) getPosition equals: 19.
	self assert: (aGame spaceshipMatching: aSpaceship3) getPosition equals: 0.
	
	self assert: (aGame spaceshipMatching: aSpaceship) getShields equals: 3.
	mercenary := (aGame spaceshipMatching: aSpaceship) getMercenaries first.
	self assert: (mercenary getShields) equals: 3.
	
]

{ #category : 'tests' }
MercenaryCardTest >> testIsValidIfSpaceshipCanPlayAnotherCardHavingAMercenary [

	| aGameBuilder aSpaceship aSpaceship2 aSpaceship3 aGame aCard aSecondCard position |
	aGameBuilder := GameBuilder new.
	position := 4.
	aCard := MercenaryCard new.
	aSecondCard := SpeedCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: aCard with: aSecondCard).
	aSpaceship2 := Spaceship new. aSpaceship3 := Spaceship new.
	
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
				   addSpaceship: aSpaceship2;
					addSpaceship: aSpaceship3;

		         addBoard: (Board withSize: 90 andWormholeFrom: 49 to: 67);
		         addDice: (SequentialFixedDice onFaces: {position. 19. 5} );
		         build.

	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries equals: (OrderedCollection with: aSpaceship2).
	self assert: ((aGame spaceshipMatching: aSpaceship) getCards size) equals:  1.
	aGame playRoundUsing: aSecondCard of: aSpaceship to: aSpaceship2.
	aGame playRound.
	self assert: ((aGame spaceshipMatching: aSpaceship) getCards size) equals:  0.
	self assert: (aGame spaceshipMatching: aSpaceship) getPosition equals: position*3 +1.
	
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
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries equals: (OrderedCollection with: aSpaceship2).
	self assert: (aGame spaceshipMatching: aSpaceship) getPosition equals: 0.
	self assert: (aGame spaceshipMatching: aSpaceship2) getPosition equals: 19.
	
	self assert: (aGame spaceshipMatching: aSpaceship) getShields equals: 2.
	self assert: ((aGame spaceshipMatching: aSpaceship) getMercenaries first getShields) equals: 2.
	
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
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries equals: (OrderedCollection with: aSpaceship2).
	
	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aGame spaceshipMatching: aSpaceship) getMercenaries equals: (OrderedCollection with: aSpaceship2).
	self assert: ((aGame spaceshipMatching: aSpaceship) getCards size) equals:  1.
	
]
