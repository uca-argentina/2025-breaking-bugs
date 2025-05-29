Class {
	#name : 'AtomicBomb',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
AtomicBomb >> applyTo: aSpaceship in: aGame [ 

	aGame getSpaceships do: [ :ship |
		ship moveToPosition: 0 .
		ship lowerAShield ].
	aGame setToNotBattle: true.
]
