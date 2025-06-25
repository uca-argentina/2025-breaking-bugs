Class {
	#name : 'AccelerationCard',
	#superclass : 'Card',
	#instVars : [
		'id'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
AccelerationCard >> = anotherCard [

^ id = anotherCard getId.
]

{ #category : 'behavior' }
AccelerationCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [ 
]

{ #category : 'behavior' }
AccelerationCard >> getId [
^ id.
]

{ #category : 'comparing' }
AccelerationCard >> hash [
   ^ self getId hash.
]

{ #category : 'behavior' }
AccelerationCard >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [ 
	aGame makeAllSpaceShipsMoveAtHigherVelocity.
	aGame registerThrownCard: self.
]

{ #category : 'initialization' }
AccelerationCard >> initialize [
id := 'Card-' , (0 to: 9999) atRandom asString.
"type := 'AccelerationCard'." 
]

{ #category : 'behavior' }
AccelerationCard >> isInstant [
	^ false.
]

{ #category : 'behavior' }
AccelerationCard >> isPermanent [

	^ true
]

{ #category : 'behavior' }
AccelerationCard >> undoEffect: aGame to: aTargetSpaceship [

	aGame makeAllSpaceShipsMoveAtLowerVelocity
]
