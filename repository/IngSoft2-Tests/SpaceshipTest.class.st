Class {
	#name : 'SpaceshipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceshipTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
SpaceshipTest >> testWhenCreatingASpaceshipThenItIsAtTheInitialPosition [

	| aSpaceship initialPosition |
	aSpaceship := Spaceship new.
	initialPosition := 0.

	self assert: (aSpaceship isAtPosition: initialPosition)
]

{ #category : 'tests' }
SpaceshipTest >> testWhenMoving3PositionsThen3IsTheFinalPosition [

	| aSpaceship finalPosition |
	aSpaceship := Spaceship new.
	finalPosition := 3.

	aSpaceship moveToPosition: finalPosition.

	self assert: (aSpaceship isAtPosition: finalPosition)
	"Este test esta mal"
]

{ #category : 'tests' }
SpaceshipTest >> testWhenRollingADiceAndGettingA3ThenTheSpaceshipMoves3Positions [

	| aSpaceship finalPosition dice |
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 3).
	aSpaceship := Spaceship with: dice.
	finalPosition := 3.
	aSpaceship move.

	self assert: (aSpaceship isAtPosition: finalPosition)
]

{ #category : 'tests' }
SpaceshipTest >> testWhenRollingTwoDiceAndGettingA3InBothThenTheSpaceshipMoves6Positions [

	| aSpaceship finalPosition dice |
	dice := OrderedCollection new.
	dice add: (FixedDice onFace: 3).
	dice add: (FixedDice onFace: 3).
	aSpaceship := Spaceship with: dice.
	finalPosition := 6.
	aSpaceship move.

	self assert: (aSpaceship isAtPosition: finalPosition)
]

{ #category : 'tests' }
SpaceshipTest >> testWhenTryingToMoveToANegativePositionTheSpaceshipIsNotAllowed [

	| aSpaceship finalPosition |
	aSpaceship := Spaceship new.
	finalPosition := -1.

	self
		should: [ aSpaceship moveToPosition: finalPosition ]
		raise: Error
		withMessageText: 'The spaceship cannot move to a negative position'
]
