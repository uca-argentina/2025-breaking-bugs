Class {
	#name : 'RedoCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
RedoCard >> = anotherCard [

^ (anotherCard compareID: id).
]

{ #category : 'behavior' }
RedoCard >> checkIfEffectCanBeApplyToTarget: aTargetSpaceship [
]

{ #category : 'comparing' }
RedoCard >> compareID: anId [ 
	^ id = anId.
]

{ #category : 'behavior' }
RedoCard >> implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame [

	| lastCardThrown copyOfLastCardThrown |
	lastCardThrown := aGame lastCardThrown.
	copyOfLastCardThrown := lastCardThrown deepCopy.
	(copyOfLastCardThrown isPermanent) ifFalse: [ Error signal: 'The way the redo card was implemented is not correct' ].
	copyOfLastCardThrown
				implementEfectBy: aSpaceship
				on: aTargetSpaceship
				in: aGame
]

{ #category : 'behavior' }
RedoCard >> implementEffect: aPermanentCard by: aSpaceship to: aTargetSpaceship in: aGame [
	| lastCardThrown copyOfLastCardThrown target |
	target := nil.
	lastCardThrown := aGame lastCardThrown.
	copyOfLastCardThrown := lastCardThrown deepCopy.
	(copyOfLastCardThrown isInstant) ifFalse: [ Error signal: 'The way the redo card was implemented is not correct' ].
	copyOfLastCardThrown class = CancelationCard 
	ifTrue: [ target := (aGame lastActivePermanentCard)].
	
	copyOfLastCardThrown implementEffect: target by: aSpaceship to: aTargetSpaceship in: aGame
	
]

{ #category : 'initialization' }
RedoCard >> initialize [
	id := 'RedoCard-' , (0 to: 9999) atRandom asString.
]

{ #category : 'behavior' }
RedoCard >> isInstant [
	^ true.
]

{ #category : 'behavior' }
RedoCard >> isPermanent [

	^ false.
]
