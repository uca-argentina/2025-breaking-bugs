Class {
	#name : 'FixedDiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
FixedDiceTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
FixedDiceTest >> testSequentialFixedDiceCannotBeCreatedWithNegativeFaceValues [

	self
		should: [ SequentialFixedDice onFaces: #(-5 2) ]
		raise: Error
		withMessageText: 'Only positive values are allowed for sequential fixed dice faces'
]

{ #category : 'tests' }
FixedDiceTest >> testWhenRollingAFixedDiceAtFace5Then5IsTheResult [
	
	| aFixedDice |
	aFixedDice := FixedDice onFace: 5.
	
	self assert: aFixedDice roll equals: 5.
]

{ #category : 'tests' }
FixedDiceTest >> testWhenRollingAFixedDiceWithACollectionThenItReturnsEachValueInOrder [
	
	| aFixedDice |
	aFixedDice := SequentialFixedDice onFaces: #(5 2).
	
	self assert: aFixedDice roll equals: 5.
	self assert: aFixedDice roll equals: 2.
	self assert: aFixedDice roll equals: 5.
]

{ #category : 'tests' }
FixedDiceTest >> testWhenTryingToCreateAFixedDiceOnANegativeFaceThenNotPossible [

	self
		should: [ FixedDice onFace: -5 ]
		raise: Error
		withMessageText: 'A fixed dice should be fixed on a positive face'
]
