Class {
	#name : 'NoEffectCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
NoEffectCard >> checkIfEffectCanBeApplyToTarget: aTarget [ 
]

{ #category : 'behavior' }
NoEffectCard >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [
]

{ #category : 'behavior' }
NoEffectCard >> implementEffectTo: aSpaceship in: aGame [
]

{ #category : 'behavior' }
NoEffectCard >> isInstant [
	^ false.
]

{ #category : 'behavior' }
NoEffectCard >> isPermanent [

	^ false
]

{ #category : 'behavior' }
NoEffectCard >> undoEffect: aGame to: anUndefinedObject [

	
]
