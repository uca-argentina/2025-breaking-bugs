Class {
	#name : 'RepeatCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
RepeatCard >> implementEffect: aCard to: aSpaceship in: aGame [

	| lastEffectApplied |
	lastEffectApplied := aGame lastTileEffectApplied.
	lastEffectApplied applyTo: aSpaceship in: aGame
]

{ #category : 'testing' }
RepeatCard >> isInstant [

	^ true
]
