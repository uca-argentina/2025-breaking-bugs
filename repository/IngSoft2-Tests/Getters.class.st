Class {
	#name : 'Getters',
	#superclass : 'Object',
	#instVars : [
		'spaceships',
		'cardActiveSize'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
Getters class >> with: aCollection [ 
	^self new initializeWith: aCollection.
]

{ #category : 'instance creation' }
Getters class >> with: aSpaceshipCollection and: aCardActiveCollection [
	^self new initializeWith: aSpaceshipCollection and: aCardActiveCollection.
]

{ #category : 'behavior' }
Getters >> getCardsOf: aSpaceship [ 
	| spaceshipResult |
	spaceshipResult := spaceships detect: [ :each |
		                   each = aSpaceship ].
	^ spaceshipResult getCards.
]

{ #category : 'getter' }
Getters >> getLapsCompletedOf: aSpaceship [

	| spaceshipResult |
	spaceshipResult := spaceships detect: [ :each |
		                   each = aSpaceship ].
	^ spaceshipResult getLapsCompleted.
]

{ #category : 'getter' }
Getters >> getMercenariesOf: aSpaceship [ 
	| spaceshipResult |
	spaceshipResult := spaceships detect: [ :each |
		                   each = aSpaceship ].
	^ spaceshipResult getMercenaries.
]

{ #category : 'getter' }
Getters >> getPositionOf: aSpaceship [
    | spaceshipResult |
spaceshipResult := (spaceships detect: [:each | each = aSpaceship]).
	 ^ (spaceshipResult getPosition).
]

{ #category : 'getter' }
Getters >> getShieldsOf: aSpaceship [ 
    | spaceshipResult |
spaceshipResult := (spaceships detect: [:each | each = aSpaceship]).
	 ^ (spaceshipResult getShields).
]

{ #category : 'initialization' }
Getters >> initializeWith: aSpaceshipCollection and: aCardActiveCollection [
	spaceships := aSpaceshipCollection.
	cardActiveSize := aCardActiveCollection size.
]

{ #category : 'behavior' }
Getters >> numberOfActivePermanentCards [

	^ cardActiveSize.
]
