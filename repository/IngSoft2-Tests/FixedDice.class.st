Class {
	#name : 'FixedDice',
	#superclass : 'Object',
	#instVars : [
		'fixedFace'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
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

	fixedFace := aFaceNumber.
]

{ #category : 'functions' }
FixedDice >> roll [
	^ fixedFace.
]
