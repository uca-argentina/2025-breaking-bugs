Class {
	#name : 'GameBuilderTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameBuilderTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
GameBuilderTest >> testGameCreationSucceedsWithValidComponents [

	| aBoard aSpaceship aGameBuilder aDice aGame |
	aBoard := Board withSize: 9 andWormholeFrom: 2 to: 5.
	aSpaceship := Spaceship new.
	aGameBuilder := GameBuilder new.
	aDice := Dice new.
	aGameBuilder addSpaceship: aSpaceship.
	aGameBuilder addBoard: aBoard.
	aGameBuilder addDice: aDice.
	aGame := aGameBuilder build.
	aGame playTurn. 
	

	
]

{ #category : 'tests' }
GameBuilderTest >> testWhenTryingToBuildAGameWithoutABoardBuildFails [

	| aSpaceship aGameBuilder aDice |
	aSpaceship := Spaceship new.
	aDice := Dice new.
	aGameBuilder := GameBuilder new.
	aGameBuilder addSpaceship: aSpaceship.
	aGameBuilder addDice: aDice.
	self
		should: [
			aGameBuilder 	build ]
		raise: Error
		withMessageText: 'Cannot build a game without a board'
	
]

{ #category : 'tests' }
GameBuilderTest >> testWhenTryingToBuildAGameWithoutDiceBuildFails [

	| aBoard aGameBuilder aSpaceship |
	aBoard := Board withSize: 9 andWormholeFrom: 2 to: 5.
	aSpaceship := Spaceship new.
	aGameBuilder := GameBuilder new.
	aGameBuilder addSpaceship: aSpaceship.
	aGameBuilder addBoard: aBoard.

	self
		should: [ aGameBuilder build ]
		raise: Error
		withMessageText: 'Cannot build a game without dice'
]

{ #category : 'tests' }
GameBuilderTest >> testWhenTryingToBuildAGameWithoutSpaceshipsBuildFails [

	| aBoard aGameBuilder |
	aBoard := Board withSize: 9 andWormholeFrom: 2 to: 5.
	aGameBuilder := GameBuilder new.

	self
		should: [
			aGameBuilder
				addBoard: aBoard;
				build ]
		raise: Error
		withMessageText: 'Cannot build a game without spaceships'
]
