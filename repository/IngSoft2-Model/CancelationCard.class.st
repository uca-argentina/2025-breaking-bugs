Class {
	#name : 'CancelationCard',
	#superclass : 'Card',
	#instVars : [
		'id'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
CancelationCard >> = anotherCard [

^ (anotherCard compareID: id).
]

{ #category : 'behavior' }
CancelationCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [
]

{ #category : 'comparing' }
CancelationCard >> compareID: anId [ 
	^ id = anId.
]

{ #category : 'behavior' }
CancelationCard >> implementEffect: aPermanentCard by: aSpaceship to: aTargetSpaceship in: aGame [

	aPermanentCard undoEffect: aGame to: aTargetSpaceship.
	aGame registerThrownCard: self
]

{ #category : 'initialization' }
CancelationCard >> initialize [
id := 'CancelationCard-' , (0 to: 9999) atRandom asString.
]

{ #category : 'testing' }
CancelationCard >> isInstant [
	^ true.
]

{ #category : 'behavior' }
CancelationCard >> isPermanent [

	^ false
]
