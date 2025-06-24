Class {
	#name : 'MercenaryCard',
	#superclass : 'Object',
	#instVars : [
		'affectedSpaceship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
MercenaryCard >> implementEffectTo: aSpaceship in: aGame [

	| mercenary |
	affectedSpaceship := aSpaceship.
	mercenary := Spaceship new.
	aSpaceship hire: mercenary.
	aGame registerThrownCard: self
]

{ #category : 'as yet unclassified' }
MercenaryCard >> isPermanent [

	^ true
]

{ #category : 'as yet unclassified' }
MercenaryCard >> undoEffect: aGame [

	affectedSpaceship fireAllMercenaries
]
