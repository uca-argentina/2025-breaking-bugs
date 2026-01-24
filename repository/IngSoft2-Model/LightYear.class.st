Class {
	#name : 'LightYear',
	#superclass : 'Distance',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
LightYear class >> with: aNumber [
	^ self new initializeWith: aNumber.
]

{ #category : 'converting' }
LightYear >> asParsec [
	^ value // 3.
]

{ #category : 'converting' }
LightYear >> initializeWith: aValue [
 value := aValue.
]
