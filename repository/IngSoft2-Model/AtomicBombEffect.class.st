Class {
	#name : 'AtomicBombEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
AtomicBombEffect >> applyTo: aSpaceship in: aGame [

	aGame spaceshipsExcept: nil do: [ :ship |
		ship moveToPosition: 0.
		ship lowerAShield
	].

	aGame disableBattleForThisTurn.
	aGame registerAppliedEffect: self.
]
