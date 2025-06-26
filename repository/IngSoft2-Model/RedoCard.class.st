Class {
	#name : 'RedoCard',
	#superclass : 'Card',
	#instVars : [
		'id'
	],
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
	copyOfLastCardThrown class = CancelationCard
		ifTrue: [
			copyOfLastCardThrown implementEffect: (aGame lastActivePermanentCard) by: aSpaceship to: aTargetSpaceship in: aGame ]
		ifFalse: [
			copyOfLastCardThrown
				implementEfectBy: aSpaceship
				on: aTargetSpaceship
				in: aGame ]
]

{ #category : 'behavior' }
RedoCard >> implementEffect: aPermanentCard by: aSpaceship to: aTargetSpaceship in: aGame [

	self implementEfectBy: aSpaceship on: aTargetSpaceship in: aGame.
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
