Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
PermanentCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [ 
	self subclassResponsibility
]

{ #category : 'behavior' }
PermanentCard >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [
	self subclassResponsibility
]

{ #category : 'behavior' }
PermanentCard >> isInstant [

	^false
]

{ #category : 'behavior' }
PermanentCard >> isPermanent [

	^true.
]

{ #category : 'behavior' }
PermanentCard >> undoEffect: aGame to: aTargetSpaceship [

	self subclassResponsibility
]
