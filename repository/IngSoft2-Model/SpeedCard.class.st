Class {
	#name : 'SpeedCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'spaceshipAffected'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
SpeedCard >> = anotherCard [

^ (anotherCard compareID: id).
]

{ #category : 'behavior' }
SpeedCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [
]

{ #category : 'comparing' }
SpeedCard >> compareID: anId [ 
	^ id = anId.
]

{ #category : 'behavior' }
SpeedCard >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [ 
	
	spaceshipAffected := aSpaceship.
	aSpaceship moveAtHigherVelocity.
	aGame registerThrownCard: self.
]

{ #category : 'initialization' }
SpeedCard >> initialize [
id := 'Card-' , (0 to: 9999) atRandom asString.

]

{ #category : 'behavior' }
SpeedCard >> undoEffect: aGame to: aTargetSpaceship [ 

	spaceshipAffected moveAtLowerVelocity
]
