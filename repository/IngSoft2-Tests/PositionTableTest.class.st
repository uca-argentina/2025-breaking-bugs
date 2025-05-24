Class {
	#name : 'PositionTableTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
PositionTableTest >> compareValues: spaceshipsPositions with: expectedPositions [
    ^ spaceshipsPositions = expectedPositions
]

{ #category : 'asserting' }
PositionTableTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
PositionTableTest >> testCannotGetPositionTableBeforeGameIsFinished [

	| aGame aSpaceship aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 10);
		         build.

	aGame playTurn.
	self
		should: [ aGame getPositionTable ]
		raise: Error
		withMessageText:
		'Cannot get position table before game ends.'
]

{ #category : 'tests' }
PositionTableTest >> testWhenGameEndsThenThePositionTableCanBeKnown [

	| aGame aSecondSpaceship aPositionTable expectedPositions aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSecondSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: Spaceship new;
					addSpaceship: aSecondSpaceship; 
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 20);
		         build.

	aGame playTurn.
	aPositionTable := (aGame getPositionTable).

	expectedPositions := OrderedCollection newFrom: #( 20 0 ).
	self assert: (self compareValues: (aPositionTable getSpaceshipsPositions) with: expectedPositions)
]

{ #category : 'tests' }
PositionTableTest >> testWhenGameEndsThenTheWinnerCanBeKnown [

	| aGame aSpaceship aPositionTable aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 20);
		         build.

	aGame playTurn.
	aPositionTable := (aGame getPositionTable).
	self assert: (aPositionTable isWinner: aSpaceship)
]

{ #category : 'tests' }
PositionTableTest >> testWhenGameEndsThenTheWinnerIsNotASpaceshipThatIsNotOnTheFinishLine [

	| aGame aSecondSpaceship aPositionTable aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSecondSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: Spaceship new;
					addSpaceship: aSecondSpaceship; 
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 20);
		         build.

	aGame playTurn.
	aPositionTable := (aGame getPositionTable).
	self deny: (aPositionTable isWinner: aSecondSpaceship).
]
