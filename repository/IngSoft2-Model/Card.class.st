Class {
	#name : 'Card',
	#superclass : 'Object',
	#instVars : [
		'id'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
Card >> compareID: anId [ 

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
