Class {
	#name : 'VelocityCardsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
VelocityCardsTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]

]

{ #category : 'tests' }
VelocityCardsTest >> testIsValidIfASpaceshipCreatedWithVelocityCardsMakesTheEffectAfterTheRoundIsPlayed [
	| aGame aSpaceship aGameBuilder positions aCard|
	
	positions := 6.
	aCard := VelocityCard new.
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (VelocityCard new)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: positions);
		         build.
		
	self assert: (aSpaceship getCards size) equals: 2.
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aSpaceship getCards size) equals: 1.
	aGame playRound.
	self assert: (aSpaceship getPosition) equals: positions*2 + 1.
	
	

]

{ #category : 'tests' }
VelocityCardsTest >> testIsValidIfASpaceshipCreatedWithVelocityCardsMakesTwiceTheEffectAfterTwoRoundsArePlayed [
	| aGame aSpaceship aGameBuilder positions aCard |
	
	positions := 6.
	aGameBuilder := GameBuilder new.
	aCard := VelocityCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (VelocityCard new)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: positions);
		         build.
		
	self assert: (aSpaceship getCards size) equals: 2.
	aGame playRoundUsing: aCard of: aSpaceship.
	aGame playRound.
	aGame playRound.
	self assert: (aSpaceship getPosition) equals: positions*3 + 2.
	self assert: (aSpaceship getCards size) equals: 1.
	
	

]

{ #category : 'tests' }
VelocityCardsTest >> testIsValidIfASpaceshipIsCreatedWithTwoRandomCards [
	
	| aSpaceship |
	aSpaceship := Spaceship new.
	self assert: (aSpaceship getCards size) equals: 2.

]

{ #category : 'tests' }
VelocityCardsTest >> testIsValidIfCardUsageAffectsOnlyOwnerAndNotTheRest [
	| aGame aSpaceship aGameBuilder positions aCard aSpaceship2 |
	
	positions := 6.
	aGameBuilder := GameBuilder new.
	aCard := VelocityCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		 			addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
					addDice: (SequentialFixedDice onFaces: #(6 4));
		         build.
		
	self assert: (aSpaceship getCards size) equals: 2.
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aSpaceship getCards size) equals: 1.
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aSpaceship getPosition) equals: positions*2 + 1.
	self assert: (aSpaceship2 getPosition) equals: 8.
	self assert: (aSpaceship getCards size) equals: 0.
	
	

]

{ #category : 'tests' }
VelocityCardsTest >> testIsValidIfCardUsageIsOnlyRemovedFromOwnersHand [
	| aGame aSpaceship aGameBuilder position1 position2 aCard aSpaceship2 |
	
	position1 := 6.
	position2 := 4.
	aGameBuilder := GameBuilder new.
	aCard := VelocityCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aSpaceship2 := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		 			addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
					addDice: (SequentialFixedDice onFaces: {position1. position2});
		         build.
		
	self assert: (aSpaceship getCards size) equals: 2.
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aSpaceship getCards size) equals: 1.
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aSpaceship getPosition) equals: position1*2 + 1.
	self assert: (aSpaceship2 getPosition) equals: position2*2 +1.
	self assert: (aSpaceship getCards size) equals: 0.
	
	

]

{ #category : 'tests' }
VelocityCardsTest >> testSpaceshipUsesTwoVelocityCardsInTwoRoundsAndMovesOnlyOnePositionMore [
	| aGame aSpaceship aGameBuilder positions aCard |
	
	positions := 6.
	aGameBuilder := GameBuilder new.
	aCard := VelocityCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: positions);
		         build.
		
	self assert: (aSpaceship getCards size) equals: 2.
	aGame playRoundUsing: aCard of: aSpaceship.
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aSpaceship getPosition) equals: positions*2 + 1.
	self assert: (aSpaceship getCards size) equals: 0.
	
	

]
