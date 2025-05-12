Class {
	#name : 'PositionTable',
	#superclass : 'Object',
	#instVars : [
		'spaceships',
		'winner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
PositionTable class >> with: aCollection [ 
	^ (self new) instanceWith: aCollection .
]

{ #category : 'instance creation' }
PositionTable class >> with: spaceships andFinishLine: aFinishLine [
	^ (self new) instanceWith: spaceships andFinishLine: aFinishLine .
]

{ #category : 'checking' }
PositionTable >> checkIf: aCollection hasTheSameLengthAs: aCollection2 [

	aCollection size = aCollection2 size ifFalse: [
		Error signal:
			'The positions passed has diferent size as the number of spaceships' ].
]

{ #category : 'checking' }
PositionTable >> compareValuesWith: aCollection [ 
	| allMatch |
	allMatch := true.
	
	self checkIf: spaceships hasTheSameLengthAs: aCollection.

	spaceships with: aCollection do: [ :aSpaceship :aValue |
		(allMatch := aSpaceship isAtPosition: aValue) ifFalse: [^ false].
	].

	^ allMatch
]

{ #category : 'behavior' }
PositionTable >> getWinner [
	^ winner.
]

{ #category : 'initialization' }
PositionTable >> instanceWith: aCollection andFinishLine: aFinishLine [
	spaceships := aCollection.
	winner := aCollection detect: [ :aSpaceship | aSpaceship isAtPosition: aFinishLine ].
]

{ #category : 'behavior' }
PositionTable >> winnerIs: aSpaceship [ 
	^ aSpaceship = winner.
]
