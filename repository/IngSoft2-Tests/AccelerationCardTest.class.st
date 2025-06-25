Class {
	#name : 'AccelerationCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AccelerationCardTest >> testIsValidIfAcelerationCardAppliesEffectCorrectlyToAllSpaceshipsAndConsumesCard [ 

	| aGame aSpaceship aGameBuilder position1 position2 aCard aSpaceship2 getter |
	
	position1 := 6.
	position2 := 4.
	aGameBuilder := GameBuilder new.
	aCard := AccelerationCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aSpaceship2 := Spaceship with: (OrderedCollection with: (aCard) with: (aCard)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		 			addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
					addDice: (SequentialFixedDice onFaces: {position1 . position2});
		         build.
	
	aGame playRoundUsing: aCard of: aSpaceship.
	getter := aGame getObjectGetter.
	self assert: (getter getCardsOf: aSpaceship)size equals: 1.
	self assert: (getter getCardsOf: aSpaceship2)size equals: 2.
	
	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship) equals: position1*2 + 1.
	self assert: (getter getPositionOf: aSpaceship2) equals: position2*2 + 2.
	
	
	

]
