Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'aNumberOfSides'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Dice class >> withSides: aNumberOfSides [ 
	^ self new initializeWithSides: aNumberOfSides.
]

{ #category : 'initialization' }
Dice >> initialize [

	| defaultNumberOfSides |
	defaultNumberOfSides := 6.

	aNumberOfSides := defaultNumberOfSides
]

{ #category : 'initialization' }
Dice >> initializeWithSides: numberOfSides [

	aNumberOfSides := numberOfSides
]

{ #category : 'as yet unclassified' }
Dice >> roll [

	^ Random new nextIntegerBetween: 1 and: aNumberOfSides
]
