Class {
	#name : 'SequentialFixedDice',
	#superclass : 'Object',
	#instVars : [
		'faceNumberCollection',
		'currentIndex'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'behavior' }
SequentialFixedDice class >> faceNumberArePositive: aFaceNumberCollection [
	aFaceNumberCollection do: [ :aFaceNumber | self faceNumberIsPositive: aFaceNumber ].

]

{ #category : 'behavior' }
SequentialFixedDice class >> faceNumberIsPositive: aFaceNumber [

	aFaceNumber <= 0 ifTrue: [
		Error signal: 'Only positive values are allowed for sequential fixed dice faces' ]

]

{ #category : 'creation' }
SequentialFixedDice class >> onFaces: aFaceNumberCollection [

	self faceNumberArePositive: aFaceNumberCollection.
	^ self new initializeOnFace: aFaceNumberCollection.
]

{ #category : 'initialization' }
SequentialFixedDice >> initializeOnFace: aFaceNumberCollection [

	faceNumberCollection := aFaceNumberCollection.
	currentIndex := 0.
]

{ #category : 'behavior' }
SequentialFixedDice >> roll [
	faceNumberCollection size = currentIndex ifTrue: [ currentIndex := 0 ].
	currentIndex := currentIndex + 1.
	^ faceNumberCollection at: currentIndex.
]
