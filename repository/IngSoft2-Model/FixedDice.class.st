Class {
	#name : 'FixedDice',
	#superclass : 'Object',
	#instVars : [
		'fixedFace'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
FixedDice class >> faceNumberIsPositive: aFaceNumber [

	aFaceNumber <= 0 ifTrue: [
		Error signal: 'A fixed dice should be fixed on a positive face' ]
]

{ #category : 'as yet unclassified' }
FixedDice class >> onFace: aFaceNumber [

	self faceNumberIsPositive: aFaceNumber.
	^ self new initializeOnFace: aFaceNumber
]

{ #category : 'initialization' }
FixedDice >> initializeOnFace: aFaceNumber [

	fixedFace := aFaceNumber
]

{ #category : 'as yet unclassified' }
FixedDice >> roll [

	^ fixedFace
]
