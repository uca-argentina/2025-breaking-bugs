Class {
	#name : 'CancelationCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
CancelationCard >> implementEffectTo: aPermanentCard in: aGame [

	aPermanentCard undoEffect: aGame.
	aGame registerThrownCard: self
]

{ #category : 'behavior' }
CancelationCard >> isPermanent [

	^ false
]
