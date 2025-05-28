Class {
	#name : 'BlackHole',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
BlackHole >> applyTo: aSpaceship in: aGame [

	| actualPosition |
	actualPosition := aSpaceship getPosition.
	aSpaceship moveToPosition: actualPosition - 4.
]
