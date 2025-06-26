Class {
	#name : 'AtomicBomb',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
AtomicBomb >> applyTo: aSpaceship in: aGame [

	aGame produceAtomicBombEffectTo: aSpaceship.
	aGame registerAppliedEffect: self
]
