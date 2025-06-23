Class {
	#name : 'CancelationCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CancelationCardTest >> testIsValidIfACancelationCardAppliesEffectCorrectlyToAnAffectedSpaceshipAndConsumesCard [  


	| aGame aSpaceship aGameBuilder position1 position2 anInstantCard aSpaceship2 aPermanentCard |
	
	position1 := 6.
	position2 := 4.
	aGameBuilder := GameBuilder new.
	anInstantCard := CancelationCard  new.
	aPermanentCard := SpeedCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aPermanentCard ) with: (anInstantCard)).
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		 			addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
					addDice: (SequentialFixedDice onFaces: {position1 . position2});
		         build.
	
	aGame playRoundUsing: aPermanentCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 1.
	self assert: (aGame getCardsOf: aSpaceship2)size equals: 2.
	
	self assert: (aGame getPositionOf: aSpaceship) equals: position1.
	self assert: (aGame getPositionOf: aSpaceship2) equals: position2.
	
	aGame play: anInstantCard of: aSpaceship on: aPermanentCard. 
	
	aGame playRound.
	
	self assert: (aGame getPositionOf: aSpaceship) equals: position1*2.
	self assert: (aGame getPositionOf: aSpaceship2) equals: position2*2.
	
	
	

]

{ #category : 'tests' }
CancelationCardTest >> testWhenCancelationCardPlayedThenMercenaryEffectIsReverted [ 


	| aGame aSpaceship aGameBuilder position1 position2 anInstantCard aSpaceship2 aPermanentCard |
	
	position1 := 6.
	position2 := 4.
	aGameBuilder := GameBuilder new.
	anInstantCard := CancelationCard  new.
	aPermanentCard := MercenaryCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aPermanentCard ) with: (anInstantCard)).
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		 			addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
					addDice: (SequentialFixedDice onFaces: {position1 . position2});
		         build.
		
	aGame playRoundUsing: aPermanentCard of: aSpaceship.
	
	self assert: (aGame getCardsOf: aSpaceship)size equals: 1.
	self assert: (aGame getCardsOf: aSpaceship2)size equals: 2.
	
	self assert: ((aGame getMercenariesOf: aSpaceship) size) equals: 1.
	
	aGame play: anInstantCard of: aSpaceship on: aPermanentCard. 
	
	aGame playRound.
	
	self assert: (aSpaceship getMercenaries size) equals: 0.
	self assert: (aSpaceship2 getMercenaries size) equals: 0.
	
	
	

]

{ #category : 'tests' }
CancelationCardTest >> testtIsValidIfACancelationCardAppliesEffectCorrectlyToAllSpaceshipsAndConsumesCard [ 

	| aGame aSpaceship aGameBuilder position1 position2 anInstantCard aSpaceship2 aPermanentCard |
	
	position1 := 6.
	position2 := 4.
	aGameBuilder := GameBuilder new.
	anInstantCard := CancelationCard  new.
	aPermanentCard := AccelerationCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: (aPermanentCard ) with: (anInstantCard)).
	aSpaceship2 := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		 			addSpaceship: aSpaceship2;
		         addBoard: (Board withSize: 90 andWormholeFrom: 80 to: 89);
					addDice: (SequentialFixedDice onFaces: {position1 . position2});
		         build.
	
	aGame playRoundUsing: aPermanentCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 1.
	self assert: (aGame getCardsOf: aSpaceship2)size equals: 2.
	
	aGame play: anInstantCard of: aSpaceship on: aPermanentCard. 
	
	aGame playRound.
	
	self assert: (aGame getPositionOf: aSpaceship) equals: position1*2.
	self assert: (aGame getPositionOf: aSpaceship2) equals: position2*2 + 1.
	
	
	

]
