Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
Card >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [

	self subclassResponsibility
]

{ #category : 'comparing' }
Card >> compareID: anId [ 

	self subclassResponsibility
]

{ #category : 'behavior' }
Card >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [

	self subclassResponsibility
]

{ #category : 'behavior' }
Card >> implementEffect: aCard to: aSpaceship in: aGame [

	self subclassResponsibility
]

{ #category : 'behavior' }
Card >> isInstant [

	self subclassResponsibility
]

{ #category : 'behavior' }
Card >> isPermanent [

	self subclassResponsibility
]

{ #category : 'behavior' }
Card >> undoEffect: aGame to: aTargetSpaceship [

	self subclassResponsibility
]
