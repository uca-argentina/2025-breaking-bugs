Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
HyperSpaceJump >> applyTo: aSpaceship [

	| actualPosition |
	actualPosition := aSpaceship getPosition.
	aSpaceship moveToPosition: actualPosition + 4.
	aSpaceship lowerAShield
]

{ #category : 'operations' }
HyperSpaceJump >> applyTo: aSpaceship in: aGame [

	self applyTo: aSpaceship
]
