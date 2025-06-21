Class {
	#name : 'VelocityCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
VelocityCard >> checkIfEffectCanBeApplyToTarget: anUndefinedObject [ 
	^ self.
]

{ #category : 'behavior' }
VelocityCard >> implementEfectBy: aSpaceship on: aTargetSpaceship [
	aSpaceship makeSpaceshipMoveAtHigherVelocity.
]
