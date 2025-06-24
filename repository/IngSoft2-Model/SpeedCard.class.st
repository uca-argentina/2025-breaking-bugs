Class {
	#name : 'SpeedCard',
	#superclass : 'Object',
	#instVars : [
		'spaceshipAffected',
		'variablisisima'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
SpeedCard >> implementEffectTo: aSpaceship in: aGame [
	
	spaceshipAffected := aSpaceship.
	aSpaceship moveAtHigherVelocity.
	aGame registerThrownCard: self.
]

{ #category : 'as yet unclassified' }
SpeedCard >> isPermanent [

	^ true
]

{ #category : 'as yet unclassified' }
SpeedCard >> undoEffect: aGame [

	spaceshipAffected moveAtLowerVelocity
]
