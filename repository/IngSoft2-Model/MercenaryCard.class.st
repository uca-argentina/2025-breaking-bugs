Class {
	#name : 'MercenaryCard',
	#superclass : 'Card',
	#instVars : [
		'affectedSpaceship',
		'id'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
MercenaryCard >> = anotherCard [

^ id = anotherCard getId.
]

{ #category : 'behavior' }
MercenaryCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [
	aTargetSpaceship ifNil: [ ^ NoEffectCard new ].
	^ self.

]

{ #category : 'behavior' }
MercenaryCard >> getId [
^ id.
]

{ #category : 'comparing' }
MercenaryCard >> hash [
   ^ self getId hash.
]

{ #category : 'behavior' }
MercenaryCard >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [
	affectedSpaceship := aSpaceship.
	aTargetSpaceship makeSpaceshipOwnedBy: aSpaceship.
	aSpaceship makeHimOwnerOf: aTargetSpaceship.
	aGame registerThrownCard: self.
]

{ #category : 'initialization' }
MercenaryCard >> initialize [
id := 'Card-' , (0 to: 9999) atRandom asString.
"type := 'SpeedCard'. "
]

{ #category : 'behavior' }
MercenaryCard >> isInstant [
	^ false.
]

{ #category : 'behavior' }
MercenaryCard >> isPermanent [

	^ true
]

{ #category : 'behavior' }
MercenaryCard >> undoEffect: aGame to: aTargetSpaceship [ 

	affectedSpaceship fire: aTargetSpaceship.
]
