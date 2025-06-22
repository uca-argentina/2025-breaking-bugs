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

	spaceshipAffected := aSpaceship .
	aSpaceship moveAtHigherVelocity.
	
]

{ #category : 'as yet unclassified' }
SpeedCard >> undoEffect: aGame [ 
	spaceshipAffected moveAtLowerVelocity .
]
