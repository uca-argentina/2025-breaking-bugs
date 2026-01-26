Class {
	#name : 'AtomicBombEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
AtomicBombEffect >> applyTo: aSpaceship in: aGame [

	aGame produceAtomicBombEffectTo: aSpaceship.
	aGame registerAppliedEffect: self
]
