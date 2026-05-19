Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
HyperSpaceJump >> applyTo: aSpaceship in: aGame [

	| actualPosition |
	actualPosition := aSpaceship getPosition.
	aSpaceship moveToPosition: actualPosition + 4.
	aSpaceship lowerAShield.
	aGame registerAppliedEffect: self
]
