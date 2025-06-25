Class {
	#name : 'ObtainCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ObtainCardTest >> testIsValidIfSpaceshipCanUseACancelationCardReceivedByTheTitle [

	| aSpaceship aSpaceship2 aGameBuilder position position2 aGame aBoard aTileBuilder aTileCollection aSpeedCard aCard |
	aGameBuilder := GameBuilder new.
	aSpeedCard := SpeedCard new. aCard := CancelationCard new.
	
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship with: (OrderedCollection with: aSpeedCard with: aSpeedCard).
	position := 6. position2 := 4.
	aTileBuilder := TilesBuilder with: 60.
	aTileBuilder with: (ObtainCard with: aCard) at: position.
	aTileCollection := aTileBuilder build.
	aBoard := Board withSize: 60 andWormholeFrom: 40 to: 45 and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: aBoard;
					setLapsToWinTo: 2;
		         addDice: (SequentialFixedDice onFaces: {position.position2});
		         build.
		
	aGame playRoundUsing: aSpeedCard of: aSpaceship2.
	self assert: (aGame getCardsOf: aSpaceship) size equals: 3.
	self assert: (aGame getCardsOf: aSpaceship2) size equals: 1.

	self assert: (aGame getPositionOf: aSpaceship) equals: position.
	self assert: (aGame getPositionOf: aSpaceship2) equals: position2.

	aGame playInstant: aCard of: aSpaceship on: aSpeedCard.

	aGame playRound.
	
	self assert: (aGame getCardsOf: aSpaceship)size equals: 2.
	
	self assert: (aGame getPositionOf: aSpaceship) equals: position * 2.
	self assert: (aGame getPositionOf: aSpaceship2) equals: position2 * 2.
	self assert: aGame numberOfActivePermanentCards equals: 0.

]

{ #category : 'tests' }
ObtainCardTest >> testIsValidIfSpaceshipCanUseAMercenaryCardReceivedByTheTitle [

	| aSpaceship aSpaceship2 aSpaceship3 aGameBuilder position aGame aBoard aTileBuilder aTileCollection aCard |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new. aSpaceship2 := Spaceship new. aSpaceship3 := Spaceship new.
	position := 6.
	aTileBuilder := TilesBuilder with: 60.
	aCard := MercenaryCard new.
	aTileBuilder with: (ObtainCard with: aCard) at: position.
	aTileCollection := aTileBuilder build.
	aBoard := Board withSize: 60 andWormholeFrom: 40 to: 45 and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: aBoard;
					setLapsToWinTo: 2;
		         addDice: (SequentialFixedDice onFaces: {position.15});
		         build.
		
	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship2.
	self assert: (aGame getMercenariesOf: aSpaceship) equals: (OrderedCollection with: aSpaceship2).

	self assert: (aGame getPositionOf: aSpaceship) equals: position.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 2.
]

{ #category : 'tests' }
ObtainCardTest >> testIsValidIfSpaceshipCanUseARedoCardReceivedByTheTitle [

	| aSpaceship aSpaceship2 aSpaceship3 aGameBuilder position aGame aBoard aTileBuilder aTileCollection aMercenaryCard aCard |
	aGameBuilder := GameBuilder new.
	aMercenaryCard := MercenaryCard new.
	aCard := RedoCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: aMercenaryCard with: aMercenaryCard).
	aSpaceship2 := Spaceship new. aSpaceship3 := Spaceship new.
	position := 6.
	aTileBuilder := TilesBuilder with: 60.
	aTileBuilder with: (ObtainCard with: aCard) at: position.
	aTileCollection := aTileBuilder build.
	aBoard := Board withSize: 60 andWormholeFrom: 40 to: 45 and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
					addSpaceship: aSpaceship3;
		         addBoard: aBoard;
					setLapsToWinTo: 2;
		         addDice: (FixedDice onFace: position);
		         build.
		
	aGame playRoundUsing: aMercenaryCard of: aSpaceship to: aSpaceship2.
	self assert: (aGame getMercenariesOf: aSpaceship) equals: (OrderedCollection with: aSpaceship2).
	self assert: (aGame getCardsOf: aSpaceship )size equals: 2.
	aGame playRoundUsing: aCard of: aSpaceship to: aSpaceship3.
	self assert: (aGame getCardsOf: aSpaceship )size equals: 1.
	self assert: (aGame getMercenariesOf: aSpaceship) equals: (OrderedCollection with: aSpaceship2 with: aSpaceship3).

]

{ #category : 'tests' }
ObtainCardTest >> testIsValidIfSpaceshipCanUseASpeedCardReceivedByTheTitle [

	| aSpaceship aSpaceship2 aSpaceship3 aGameBuilder position aGame aBoard aTileBuilder aTileCollection aCard |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	position := 6.
	aTileBuilder := TilesBuilder with: 60.
	aCard := SpeedCard new.
	aTileBuilder with: (ObtainCard with: aCard) at: position.
	aTileCollection := aTileBuilder build.
	aBoard := Board withSize: 60 andWormholeFrom: 40 to: 45 and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: aBoard;
					setLapsToWinTo: 2;
		         addDice: (FixedDice onFace: position);
		         build.
	aGame playRoundUsing: aCard of: aSpaceship.
	aGame playRound.

	self assert: (aGame getPositionOf: aSpaceship) equals: position*2+1.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 2.

]

{ #category : 'tests' }
ObtainCardTest >> testIsValidIfSpaceshipCanUseAnAccelerationCardReceivedByTheTitle [

	| aSpaceship aSpaceship2 aSpaceship3 aGameBuilder position aGame aBoard aTileBuilder aTileCollection aCard |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new. aSpaceship2 := Spaceship new. aSpaceship3 := Spaceship new.
	position := 6.
	aTileBuilder := TilesBuilder with: 60.
	aCard := AccelerationCard new.
	aTileBuilder with: (ObtainCard with: aCard) at: position.
	aTileCollection := aTileBuilder build.
	aBoard := Board withSize: 60 andWormholeFrom: 40 to: 45 and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: aBoard;
					setLapsToWinTo: 2;
		         addDice: (FixedDice onFace: position);
		         build.
		
	aGame playRoundUsing: aCard of: aSpaceship.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 2.
	self assert: (aGame getCardsOf: aSpaceship2)size equals: 2.
	
	aGame playRound.
	
	self assert: (aGame getPositionOf: aSpaceship) equals: position*2 + 1.
	self assert: (aGame getPositionOf: aSpaceship2) equals: position*2 + 2.

]

{ #category : 'tests' }
ObtainCardTest >> testIsValidIfSpaceshipReceivesCardWhenLandingOnCardTile [

	| aSpaceship aSpaceship2 aSpaceship3 aGameBuilder finishLine aGame aBoard aTileBuilder aTileCollection |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	finishLine := 20.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder with: (ObtainCard new) at: 4.
	aTileCollection := aTileBuilder build.
	aBoard := Board withSize: finishLine andWormholeFrom: 8 to: 15 and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: aBoard;
					setLapsToWinTo: 2;
		         addDice: (FixedDice onFace: 4);
		         build.
	aGame playRound.

	self assert: (aGame getPositionOf: aSpaceship) equals: 4.
	self assert: (aGame getCardsOf: aSpaceship)size equals: 3.

]
