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
MoonWalk >> applyTo: aSpaceship [ 
	| actualPosition |
	actualPosition := aSpaceship getPosition.
	aSpaceship moveToPosition: (actualPosition - 4)
]

{ #category : 'operations' }
MoonWalk >> applyTo: aSpaceship in: aGame [
	| boardSize otherSpaceships newPosition|
	boardSize := aGame getBoardSize.
	otherSpaceships := aGame getSpaceships reject: [ :each | each = aSpaceship ].

	otherSpaceships do: [ :ship |
		
		newPosition := ((ship getPosition - numberOfPositionsToGoBack ) \\ boardSize) + 1.
		ship moveToPosition: newPosition
	].

]

{ #category : 'initialization' }
MoonWalk >> initializeFor: aNumberOfPositionsToGoBack [

	numberOfPositionsToGoBack := aNumberOfPositionsToGoBack
]
