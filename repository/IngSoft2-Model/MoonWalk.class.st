Class {
	#name : 'MoonWalk',
	#superclass : 'Object',
	#instVars : [
		'numberOfPositionsToGoBack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
MoonWalk class >> for: aNumberOfPositionToGoBack [

	^ self new initializeFor: aNumberOfPositionToGoBack
]

{ #category : 'operations' }
MoonWalk >> applyTo: aSpaceship in: aGame [

	aGame
		produceMoonwalkEffectTo: aSpaceship
		with: numberOfPositionsToGoBack.
	aGame registerAppliedEffect: self
]

{ #category : 'initialization' }
MoonWalk >> initializeFor: aNumberOfPositionsToGoBack [

	numberOfPositionsToGoBack := aNumberOfPositionsToGoBack
]
