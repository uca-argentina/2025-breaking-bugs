Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
InstantCard >> implementEffect: aPermanentCard by: aSpaceship to: aTargetSpaceship in: aGame [
self subclassResponsibility
]

{ #category : 'behavior' }
InstantCard >> isInstant [

	^ true.
]

{ #category : 'behavior' }
InstantCard >> isPermanent [

	^ false
]
