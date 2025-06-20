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
	| aGame aSpaceship aGameBuilder positions|
	
	positions := 6.
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship with: (OrderedCollection with: (VelocityCard new) with: (VelocityCard new)).
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: positions);
		         build.
		
	self assert: (aSpaceship getCards size) equals: 2.
	aGame playRoundUsingCardOf: aSpaceship.
	self assert: (aSpaceship getCards size) equals: 1.
	aGame playRound.
	self assert: (aSpaceship getPosition) equals: positions*2 + 1.
	
	

]

{ #category : 'tests' }
VelocityCardsTest >> testIsValidIfASpaceshipCreatedWithVelocityCardsMakesTwiceTheEffectAfterTwoRoundsArePlayed [
	| aGame aSpaceship aGameBuilder positions|
	
	positions := 6.
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: positions);
		         build.
		
	self assert: (aSpaceship getCards size) equals: 2.
	aGame playRoundUsingCardOf: aSpaceship.
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
VelocityCardsTest >> testSpaceshipUsesTwoVelocityCardsInTwoRoundsAndMovesOnlyOnePositionMore [
	| aGame aSpaceship aGameBuilder positions|
	
	positions := 6.
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
					addDice: (FixedDice onFace: positions);
		         build.
		
	self assert: (aSpaceship getCards size) equals: 2.
	aGame playRoundUsingCardOf: aSpaceship.
	aGame playRoundUsingCardOf: aSpaceship.
	self assert: (aSpaceship getPosition) equals: positions*2 + 1.
	self assert: (aSpaceship getCards size) equals: 0.
	
	

]
