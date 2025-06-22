Class {
	#name : 'SpeedCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
SpeedCard >> implementEffectTo: aSpaceship in: aGame [
	aSpaceship moveAtHigherVelocity.
]
