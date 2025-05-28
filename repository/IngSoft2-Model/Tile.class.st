Class {
	#name : 'Tile',
	#superclass : 'Object',
	#instVars : [
		'effect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Tile class >> with: anEffect [

	^ self new initializeWith: anEffect
]

{ #category : 'as yet unclassified' }
Tile >> applyEffectTo: aSpaceship [

	effect applyTo: aSpaceship
]

{ #category : 'as yet unclassified' }
Tile >> applyEffectTo: aSpaceship in: aGame [

	effect applyTo: aSpaceship in: aGame
]

{ #category : 'initialization' }
Tile >> initializeWith: anEffect [

	effect := anEffect
]
