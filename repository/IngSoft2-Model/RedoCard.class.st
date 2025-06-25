Class {
	#name : 'RedoCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
RedoCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [
]

{ #category : 'behavior' }
RedoCard >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [

	| lastCardThrown copyOfLastCardThrown |
	lastCardThrown := aGame lastCardThrown.
	copyOfLastCardThrown := lastCardThrown deepCopy.
	copyOfLastCardThrown class = CancelationCard
		ifTrue: [
			copyOfLastCardThrown implementEffect: (aGame lastActivePermanentCard) to: aTargetSpaceship in: aGame ]
		ifFalse: [
			copyOfLastCardThrown
				implementEfectBy: aSpaceship
				on: aTargetSpaceship
				in: aGame ]
]

{ #category : 'behavior' }
RedoCard >> isInstant [
	^ false.
]

{ #category : 'behavior' }
RedoCard >> isPermanent [

	^ false
]
