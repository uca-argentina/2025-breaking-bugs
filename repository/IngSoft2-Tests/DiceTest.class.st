Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
DiceTest >> testWhenRollingADiceThenItIsBetween1And6 [

	| aDice |
	aDice := Dice new.

	self assert: (aDice roll between: 1 and: 6)
]

{ #category : 'tests' }
DiceTest >> testWhenRollingADiceWithNSidesThenItIsBetween1AndN [

	| aDice numberOfDiceSides |
	numberOfDiceSides := 2.

	aDice := Dice withSides: numberOfDiceSides.

	self assert: (aDice roll between: 1 and: numberOfDiceSides)
]

{ #category : 'tests' }
DiceTest >> testWhenTryingToCreateADiceWithNegativeAmountOfSidesThenNotPossible [

	| numberOfDiceSides |
	numberOfDiceSides := -3.

	self
		should: [ Dice withSides: numberOfDiceSides ]
		raise: Error 
		withMessageText: 'A dice should have a positive amount of sides'
]
