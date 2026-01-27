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
	| newPosition |
	aGame spaceshipsExcept: aSpaceship do: [ :ship |
		newPosition := aGame
			positionAfterMovingBack: numberOfPositionsToGoBack
			for: ship.
		ship moveToPosition: newPosition
	].

	aGame registerAppliedEffect: self.
]

{ #category : 'initialization' }
MoonWalkEffect >> initializeFor: aNumberOfPositionsToGoBack [

	numberOfPositionsToGoBack := aNumberOfPositionsToGoBack
]
