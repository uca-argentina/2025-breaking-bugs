Class {
	#name : 'MercenaryCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
MercenaryCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [
	aTargetSpaceship ifNil: [ ^ NoEffectCard new ].
	^ self.
]

{ #category : 'behavior' }
MercenaryCard >> implementEfectBy: aSpaceship on: aTargetSpaceship [
	aTargetSpaceship makeSpaceshipOwnedBy: aSpaceship.
	aSpaceship makeHimOwnerOf: aTargetSpaceship
]
