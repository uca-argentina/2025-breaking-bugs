Class {
	#name : 'AccelerationCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
AccelerationCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [ 
]

{ #category : 'behavior' }
AccelerationCard >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [ 
	aGame makeAllSpaceShipsMoveAtHigherVelocity.
	aGame registerThrownCard: self.
]

{ #category : 'behavior' }
AccelerationCard >> implementEffectTo: aSpaceship in: aGame [

	aGame makeAllSpaceShipsMoveAtHigherVelocity.
	aGame registerThrownCard: self
]

{ #category : 'behavior' }
AccelerationCard >> isPermanent [

	^ true
]

{ #category : 'behavior' }
AccelerationCard >> undoEffect: aGame [
	aGame makeAllSpaceShipsMoveAtLowerVelocity
]

{ #category : 'behavior' }
AccelerationCard >> undoEffect: aGame to: aTargetSpaceship [

	aGame makeAllSpaceShipsMoveAtLowerVelocity
]
