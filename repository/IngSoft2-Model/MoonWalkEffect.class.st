Class {
	#name : 'MoonWalkEffect',
	#superclass : 'Effect',
	#instVars : [
		'numberOfPositionsToGoBack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
MoonWalkEffect class >> for: aNumberOfPositionToGoBack [

	^ self new initializeFor: aNumberOfPositionToGoBack
]

{ #category : 'operations' }
MoonWalkEffect >> applyTo: aSpaceship in: aGame [

	aGame
		produceMoonwalkEffectTo: aSpaceship
		with: numberOfPositionsToGoBack.
	aGame registerAppliedEffect: self
]

{ #category : 'initialization' }
MoonWalkEffect >> initializeFor: aNumberOfPositionsToGoBack [

	numberOfPositionsToGoBack := aNumberOfPositionsToGoBack
]
