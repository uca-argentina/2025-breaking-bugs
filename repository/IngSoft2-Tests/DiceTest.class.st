Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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
