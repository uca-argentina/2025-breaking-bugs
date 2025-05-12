Class {
	#name : 'PositionTable',
	#superclass : 'Object',
	#instVars : [
		'spaceships',
		'winner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
PositionTable class >> with: aCollection [ 
	^ (self new) instanceWith: aCollection .
]

{ #category : 'instance creation' }
PositionTable class >> with: spaceships andFinishLine: aFinishLine [
	^ (self new) instanceWith: spaceships andFinishLine: aFinishLine .
]
