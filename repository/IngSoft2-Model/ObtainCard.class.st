Class {
	#name : 'ObtainCard',
	#superclass : 'Effect',
	#instVars : [
		'cardSupplier'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ObtainCard class >> new [
	^ super new initializeWith: [ RandomCard obtainCard ].
]

{ #category : 'instance creation' }
ObtainCard class >> with: aSpecificCard [ 
	^ self new initializeWith: [ aSpecificCard ].
]

{ #category : 'operations' }
ObtainCard >> applyTo: aSpaceship in: aGame [
    aSpaceship addNewCard: (cardSupplier value).
	
]

{ #category : 'initialization' }
ObtainCard >> initializeWith: aCard [
	cardSupplier := aCard.
]
