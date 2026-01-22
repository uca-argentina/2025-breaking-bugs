Class {
	#name : 'AccelerationCard',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
AccelerationCard >> = anotherCard [

^ (anotherCard compareID: id).
]

{ #category : 'behavior' }
AccelerationCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [ 
]

{ #category : 'comparing' }
AccelerationCard >> compareID: anId [ 
	^ id = anId.
]

{ #category : 'behavior' }
AccelerationCard >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [ 
	aGame makeAllSpaceShipsMoveAtHigherVelocity.
	aGame registerThrownCard: self.
]

{ #category : 'initialization' }
AccelerationCard >> initialize [
id := 'AccelerationCard-' , (0 to: 9999) atRandom asString.
]

{ #category : 'behavior' }
AccelerationCard >> undoEffect: aGame to: aTargetSpaceship [

	aGame makeAllSpaceShipsMoveAtLowerVelocity
]
