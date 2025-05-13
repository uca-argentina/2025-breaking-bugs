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
Dice class >> new [

	| aDefaultNumberOfSides dice |
	aDefaultNumberOfSides := 6.
	dice := super new.
	^ dice initializeWithSides: aDefaultNumberOfSides
]

{ #category : 'as yet unclassified' }
Dice class >> numberOfSidesIsPositive: aNumberOfSides [

	aNumberOfSides <= 0 ifTrue: [
		Error signal: 'A dice should have a positive amount of sides' ]
]

{ #category : 'as yet unclassified' }
Dice class >> withSides: aNumberOfSides [

	self numberOfSidesIsPositive: aNumberOfSides.
	^ self new initializeWithSides: aNumberOfSides
]

{ #category : 'initialization' }
Dice >> initializeWithSides: numberOfSides [

	aNumberOfSides := numberOfSides
]

{ #category : 'roll' }
Dice >> roll [

	^ Random new nextIntegerBetween: 1 and: aNumberOfSides
	
]
