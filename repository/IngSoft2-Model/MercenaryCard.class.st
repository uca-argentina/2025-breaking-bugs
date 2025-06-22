Class {
	#name : 'MercenaryCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
MercenaryCard >> implementEffectTo: aSpaceship in: aGame [

	| mercenary |
	mercenary := Spaceship new.
	aSpaceship hire: mercenary
]
