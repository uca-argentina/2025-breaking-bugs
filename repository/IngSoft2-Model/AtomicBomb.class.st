Class {
	#name : 'AtomicBomb',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
AtomicBomb >> applyTo: aSpaceship in: aGame [ 

	aGame produceAtomicBombEffectTo: aSpaceship. 
]
