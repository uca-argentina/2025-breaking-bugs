Class {
	#name : 'VelocityCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
VelocityCard >> implementEfectOn: aSpaceship [
	aSpaceship makeSpaceshipMoveAtHigherVelocity.
]

{ #category : 'behavior' }
VelocityCard >> implementEfectby: aSpaceship on: aTargetSpaceship [
	aSpaceship makeSpaceshipMoveAtHigherVelocity.
]
