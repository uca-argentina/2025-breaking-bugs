Class {
	#name : 'RepeatCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
RepeatCard >> compareID: anId [ 
	^ false.
]

{ #category : 'behavior' }
RepeatCard >> implementEffect: aPermanentCard by: aSpaceship to: aTargetSpaceship in: aGame [

	| lastEffectApplied |
	lastEffectApplied := aGame lastTileEffectApplied.
	lastEffectApplied applyTo: aTargetSpaceship in: aGame
]

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
