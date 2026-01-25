Class {
	#name : 'Distance',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Distance >> calculateLapsIn: aPosition [
	^ aPosition // value
]

{ #category : 'as yet unclassified' }
Distance >> calculatePositionIn: aPosition [
	^ aPosition \\ value
]

{ #category : 'as yet unclassified' }
Distance >> checkIfEquals: anotherDistance [
    ^ value = anotherDistance.
]

{ #category : 'as yet unclassified' }
Distance >> lessThan: aValue [ 
	^ value < aValue.
]

{ #category : 'as yet unclassified' }
Distance >> validate [
		value <= 0 ifTrue: [
		Error signal: 'The length of the board should be positive' ]
]
