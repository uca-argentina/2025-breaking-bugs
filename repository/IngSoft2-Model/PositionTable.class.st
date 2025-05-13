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
PositionTable class >> with: spaceships and: aFinishLine [

	^ self new instanceWith: spaceships and: aFinishLine
]

{ #category : 'checking' }
PositionTable >> checkIf: aCollection hasTheSameLengthAs: aCollection2 [

	aCollection size = aCollection2 size ifFalse: [
		Error signal:
			'The positions passed has diferent size as the number of spaceships' ].
]

{ #category : 'checking' }
PositionTable >> compareValuesWith: expectedPositions [

	| allMatch |
	allMatch := true.

	self checkIf: spaceships hasTheSameLengthAs: expectedPositions.

	spaceships
		with: expectedPositions
		do: [ :aSpaceship :anExpectedPosition |
			(allMatch := aSpaceship isAtPosition: anExpectedPosition) ifFalse: [
				^ false ] ].

	^ allMatch
]

{ #category : 'behavior' }
PositionTable >> getWinner [

	^ winner
]

{ #category : 'initialization' }
PositionTable >> instanceWith: aCollectionOfSpaceships and: aFinishLine [

	spaceships := aCollectionOfSpaceships.
	winner := aCollectionOfSpaceships detect: [ :aSpaceship |
		          aSpaceship isAtPosition: aFinishLine ]
]

{ #category : 'behavior' }
PositionTable >> isWinner: aSpaceship [

	^ aSpaceship = winner
]
