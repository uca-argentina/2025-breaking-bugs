Class {
	#name : 'BlackHoleEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
BlackHoleEffect >> applyTo: aSpaceship in: aGame [

	| actualPosition |
	actualPosition := aSpaceship getPosition.
	aSpaceship moveToPosition: actualPosition - 4.
	aGame registerAppliedEffect: self
]
