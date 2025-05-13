Class {
	#name : 'PositionTableTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
PositionTableTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
PositionTableTest >> testFailMorePositionsThanSpaceships [

	| aGame aBoard aSpaceship dice aPositionTable expectedPositions aGameBuilder |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 3.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 6).
	aSpaceship := Spaceship with: dice.
	aGameBuilder := GameBuilder new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: aBoard;
		         build.
	expectedPositions := OrderedCollection newFrom: #( 10 2 5 ).

	aGame playTurn.
	aPositionTable := aGame getPositionTable.
	self
		should: [
		aPositionTable compareValuesWith: expectedPositions ]
		raise: Error
		withMessageText:
		'The positions passed has diferent size as the number of spaceships'
]

{ #category : 'tests' }
PositionTableTest >> testWhenGameEndsThenThePositionTableCanBeKnown [

	| aGame aBoard aSpaceship aSecondSpaceship dice aPositionTable expectedPositions aGameBuilder |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 3.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 6).
	aSpaceship := Spaceship with: dice.
	aSecondSpaceship := Spaceship with: dice.

	aGameBuilder := GameBuilder new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSecondSpaceship;
		         addBoard: aBoard;
		         build.

	expectedPositions := OrderedCollection newFrom: #( 6 0 ).

	aGame playTurn.
	aPositionTable := aGame getPositionTable.
	self assert:
		(aPositionTable compareValuesWith: expectedPositions)
]

{ #category : 'tests' }
PositionTableTest >> testWhenGameEndsThenTheWinnerCanBeKnown [

	| aGame aBoard aSpaceship aSecondSpaceship dice aPositionTable aGameBuilder |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 3.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 6).
	aSpaceship := Spaceship with: dice.
	aSecondSpaceship := Spaceship with: dice.

	aGameBuilder := GameBuilder new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSecondSpaceship;
		         addBoard: aBoard;
		         build.

	aGame playTurn.
	aPositionTable := aGame getPositionTable.
	self assert: (aPositionTable isWinner: aSpaceship)
]

{ #category : 'tests' }
PositionTableTest >> testWhenGameEndsThenTheWinnerIsNotASpaceshipThatIsNotOnTheFinishLine [

	| aGame aBoard aSpaceship aSecondSpaceship dice aPositionTable expectedPositions aGameBuilder |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 3.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 6).
	aSpaceship := Spaceship with: dice.
	aSecondSpaceship := Spaceship with: dice.

	aGameBuilder := GameBuilder new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSecondSpaceship;
		         addBoard: aBoard;
		         build.

	expectedPositions := OrderedCollection newFrom: #( 6 0 ).

	aGame playTurn.
	aPositionTable := aGame getPositionTable.
	self deny: (aPositionTable isWinner: aSecondSpaceship)
]
