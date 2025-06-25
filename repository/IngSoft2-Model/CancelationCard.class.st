Class {
	#name : 'CancelationCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
CancelationCard >> implementEffect: aPermanentCard to: aTargetSpaceship in: aGame [

	aPermanentCard undoEffect: aGame to: aTargetSpaceship.
	aGame registerThrownCard: self
]

{ #category : 'testing' }
CancelationCard >> isInstant [
	^ true.
]

{ #category : 'behavior' }
CancelationCard >> isPermanent [

	^ false
]
