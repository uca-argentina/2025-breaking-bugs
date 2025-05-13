Class {
	#name : 'WinTableTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
WinTableTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
WinTableTest >> testFailMorePositionsThanSpaceships [

	| aGame aBoard aSpaceship dice aPositionTable anOrderCollectionForTable aGameBuilder |
	aBoard := Board withSize: 6 andWormholeFrom: 2 to: 3.
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 6).
	aSpaceship := Spaceship with: dice.
	aGameBuilder := GameBuilder new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: aBoard;
		         build.
	anOrderCollectionForTable := OrderedCollection newFrom: #( 10 2 5 ).

	aGame playTurn.
	aPositionTable := aGame getPositionTable.
	self
		should: [
		aPositionTable compareValuesWith: anOrderCollectionForTable ]
		raise: Error
		withMessageText:
		'The positions passed has diferent size as the number of spaceships'
]

{ #category : 'tests' }
WinTableTest >> testWhenGameEndItDontReturnALosser [

	| aGame aBoard aSpaceship aSecondSpaceship dice aPositionTable anOrderCollectionForTable aGameBuilder |
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

	anOrderCollectionForTable := OrderedCollection newFrom: #( 6 0 ).

	aGame playTurn.
	aPositionTable := aGame getPositionTable.
	self deny: (aPositionTable winnerIs: aSecondSpaceship)
]

{ #category : 'tests' }
WinTableTest >> testWhenGameEndReturnsPositionTable [

	| aGame aBoard aSpaceship aSecondSpaceship dice aPositionTable anOrderCollectionForTable aGameBuilder |
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

	anOrderCollectionForTable := OrderedCollection newFrom: #( 6 0 ).

	aGame playTurn.
	aPositionTable := aGame getPositionTable.
	self assert:
		(aPositionTable compareValuesWith: anOrderCollectionForTable)
]

{ #category : 'tests' }
WinTableTest >> testWhenGameEndReturnsWinner [

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
	self assert: (aPositionTable winnerIs: aSpaceship)
]
