Class {
	#name : 'MercenaryCard',
	#superclass : 'Object',
	#instVars : [
		'affectedSpaceship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
MercenaryCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [
	aTargetSpaceship ifNil: [ ^ NoEffectCard new ].
	^ self.

]

{ #category : 'behavior' }
MercenaryCard >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [
	affectedSpaceship := aSpaceship.
	aTargetSpaceship makeSpaceshipOwnedBy: aSpaceship.
	aSpaceship makeHimOwnerOf: aTargetSpaceship.
	aGame registerThrownCard: self.
]

{ #category : 'behavior' }
MercenaryCard >> isPermanent [

	^ true
]

{ #category : 'behavior' }
MercenaryCard >> undoEffect: aGame to: aTargetSpaceship [ 

	affectedSpaceship fire: aTargetSpaceship.
]
