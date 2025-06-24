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
SpeedCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [
]

{ #category : 'behavior' }
SpeedCard >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [ 
	
	spaceshipAffected := aSpaceship.
	aSpaceship moveAtHigherVelocity.
	aGame registerThrownCard: self.
]

{ #category : 'behavior' }
SpeedCard >> isPermanent [

	^ true
]

{ #category : 'behavior' }
SpeedCard >> undoEffect: aGame to: aTargetSpaceship [ 

	spaceshipAffected moveAtLowerVelocity
]
