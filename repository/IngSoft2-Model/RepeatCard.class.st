Class {
	#name : 'RepeatCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
RepeatCard >> = anotherCard [

^ (anotherCard compareID: id).
]

{ #category : 'comparing' }
RepeatCard >> compareID: anId [ 
	^ false.
]

{ #category : 'behavior' }
RepeatCard >> implementEffect: aPermanentCard by: aSpaceship to: aTargetSpaceship in: aGame [

	| lastEffectApplied |
	lastEffectApplied := aGame lastTileEffectApplied.
	lastEffectApplied applyTo: aTargetSpaceship in: aGame.
	aGame registerThrownCard: self.
]

{ #category : 'initialization' }
RepeatCard >> initialize [

	id := 'RepeatCard-' , (0 to: 9999) atRandom asString
]
