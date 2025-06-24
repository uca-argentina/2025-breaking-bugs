Class {
	#name : 'NoEffectCard',
	#superclass : 'Object',
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
NoEffectCard >> isPermanent [

	^ false
]
