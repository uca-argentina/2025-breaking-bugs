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
GameBuilderTest >> testWhenTryingToBuildAGameWithoutABoardBuildFails [

	| aSpaceship dice aGameBuilder |
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 5).
	aSpaceship := Spaceship with: dice.

	aGameBuilder := GameBuilder new.

	self
		should: [
			aGameBuilder
				addSpaceship: aSpaceship;
				build ]
		raise: Error
		withMessageText: 'Cannot build a game without a board'
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
