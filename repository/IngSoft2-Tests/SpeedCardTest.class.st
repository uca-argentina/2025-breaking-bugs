Class {
	#name : 'SpeedCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpeedCardTest >> testIsValidIfASpaceshipCreatedWithVelocityCardsMakesTheEffectAfterTheRoundIsPlayed [
	| aGame aSpaceship aGameBuilder positions aCard|
	
	positions := 6.
	aCard := SpeedCard new.
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (SpeedCard new)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: positions);
		         build.
		
	self assert: (aGame getCardsOf: aSpaceship )size equals: 2.
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship )size equals: 1.
	aGame playRound.
	self assert: (aGame getPositionOf: aSpaceship) equals: positions*2 + 1.
	
	

]

{ #category : 'tests' }
SpeedCardTest >> testIsValidIfASpaceshipCreatedWithVelocityCardsMakesTwiceTheEffectAfterTwoRoundsArePlayed [
	| aGame aSpaceship aGameBuilder positions aCard |
	
	positions := 6.
	aGameBuilder := GameBuilder new.
	aCard := SpeedCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (SpeedCard new)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: positions);
		         build.
		
	self assert: (aGame getCardsOf: aSpaceship)size equals: 2.

	aGame playRoundUsing: aCard of: aSpaceship.
	aGame playRound.
	aGame playRound.
	self assert: (aGame getPositionOf: aSpaceship) equals: positions*3 + 2.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 1.
	
	

	
	

]

{ #category : 'tests' }
SpeedCardTest >> testIsValidIfASpaceshipIsCreatedWithTwoRandomCards [
	
	| aSpaceship |
	aSpaceship := Spaceship new.
	self assert: (aSpaceship getCards size) equals: 2.

]

{ #category : 'tests' }
SpeedCardTest >> testIsValidIfCardUsageAffectsOnlyOwnerAndNotTheRest [
	| aGame aSpaceship aGameBuilder positions aCard aSpaceship2 |
	
	positions := 6.
	aGameBuilder := GameBuilder new.
	aCard := SpeedCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		 			addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
					addDice: (SequentialFixedDice onFaces: #(6 4));
		         build.
	
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 1.
	self assert: (aGame getCardsOf: aSpaceship2)size equals: 2.
	
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 0.
	self assert: (aGame getCardsOf: aSpaceship2)size equals: 2.
	
	self assert: (aGame getPositionOf: aSpaceship) equals: positions*2 + 1.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 8.
	
	
	

]

{ #category : 'tests' }
SpeedCardTest >> testIsValidIfCardUsageAffectsOnlyOwnerAndNotTheRest2 [
	| aGame aSpaceship aGameBuilder positions aCard aSpaceship2 |
	
	positions := 6.
	aGameBuilder := GameBuilder new.
	aCard := SpeedCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aSpaceship2 := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		 			addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
					addDice: (SequentialFixedDice onFaces: #(6 4));
		         build.
	
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 1.
	self assert: (aGame getCardsOf: aSpaceship2)size equals: 2.
	
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 0.
	self assert: (aGame getCardsOf: aSpaceship2)size equals: 2.
	
	self assert: (aGame getPositionOf: aSpaceship) equals: positions*2 + 1.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 8.
	
	
	

]

{ #category : 'tests' }
SpeedCardTest >> testIsValidIfCardUsageIsOnlyRemovedFromOwnersHand [
	| aGame aSpaceship aGameBuilder position1 position2 aCard aSpaceship2 |
	
	position1 := 6.
	position2 := 4.
	aGameBuilder := GameBuilder new.
	aCard := SpeedCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aSpaceship2 := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		 			addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
					addDice: (SequentialFixedDice onFaces: {position1. position2});
		         build.
		
	self assert: (aGame getCardsOf: aSpaceship)size equals: 2.
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 1.
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aGame getPositionOf: aSpaceship) equals: position1*2 + 1.
	self assert: (aGame getPositionOf: aSpaceship) equals: position1*2 + 1.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 0.
	
	

]

{ #category : 'tests' }
SpeedCardTest >> testIsValidIfVelocityCardAppliesEffectCorrectlyToEachSpaceshipAndConsumesCard [

	| aGame aSpaceship aGameBuilder position1 position2 aCard aSpaceship2 |
	
	position1 := 6.
	position2 := 4.
	aGameBuilder := GameBuilder new.
	aCard := SpeedCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aSpaceship2 := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		 			addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
					addDice: (SequentialFixedDice onFaces: {position1 . position2});
		         build.
	
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 1.
	self assert: (aGame getCardsOf: aSpaceship2)size equals: 2.
	
	aGame playRoundUsing: aCard of: aSpaceship2.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 1.
	self assert: (aGame getCardsOf: aSpaceship2)size equals: 1.
	
	aGame playRound.
	
	self assert: (aGame getPositionOf: aSpaceship) equals: position1*3 + 2.
	self assert: (aGame getPositionOf: aSpaceship2) equals: position2*3 + 1.
	
	
	

]

{ #category : 'tests' }
SpeedCardTest >> testSpaceshipUsesTwoVelocityCardsInTwoRoundsAndMovesOnlyOnePositionMore [
	| aGame aSpaceship aGameBuilder positions aCard |
	
	positions := 6.
	aGameBuilder := GameBuilder new.
	aCard := SpeedCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: positions);
		         build.
		
	self assert: (aGame getCardsOf: aSpaceship)size equals: 2.
	aGame playRoundUsing: aCard of: aSpaceship.
	aGame playRoundUsing: aCard of: aSpaceship.
	
	self assert: (aGame getPositionOf: aSpaceship) equals: positions*2 + 1.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 0.
	
	

]
