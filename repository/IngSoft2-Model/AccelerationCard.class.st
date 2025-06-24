Class {
	#name : 'AccelerationCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AccelerationCard >> implementEffectTo: aSpaceship in: aGame [

	aGame makeAllSpaceShipsMoveAtHigherVelocity.
	aGame registerThrownCard: self
]

{ #category : 'as yet unclassified' }
AccelerationCard >> isPermanent [

	^ true
]

{ #category : 'as yet unclassified' }
AccelerationCard >> undoEffect: aGame [

	aGame makeAllSpaceShipsMoveAtLowerVelocity
]
