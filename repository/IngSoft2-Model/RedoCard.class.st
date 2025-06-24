Class {
	#name : 'RedoCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
RedoCard >> implementEffectTo: aSpaceship in: aGame [

	| lastCardThrown copyOfLastCardThrown |
	lastCardThrown := aGame lastCardThrown.
	copyOfLastCardThrown := lastCardThrown deepCopy.
	copyOfLastCardThrown class = CancelationCard
		ifTrue: [
			copyOfLastCardThrown
				implementEffectTo: aGame lastActivePermanentCard
				in: aGame ]
		ifFalse: [
		copyOfLastCardThrown implementEffectTo: aSpaceship in: aGame ]
]

{ #category : 'behavior' }
RedoCard >> isPermanent [

	^ false
]
