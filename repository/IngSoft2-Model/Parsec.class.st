Class {
	#name : 'Parsec',
	#superclass : 'Distance',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Parsec class >> with: aNumber [
	^ self new initializeWith: aNumber.
	
]

{ #category : 'converting' }
Parsec >> asParsec [
	^ value.
]

{ #category : 'initialization' }
Parsec >> initializeWith: aValue [
 value := aValue.
]
