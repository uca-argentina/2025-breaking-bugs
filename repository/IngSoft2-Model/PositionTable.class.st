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

{ #category : 'behavior' }
PositionTable >> getRanking [

	^ spaceships asSortedCollection: [ :s1 :s2 |
		(s1 getLapsCompleted = s2 getLapsCompleted)
			ifTrue: [ s1 getPosition > s2 getPosition ]
			ifFalse: [ s1 getLapsCompleted > s2 getLapsCompleted ]
	]
]

{ #category : 'checking' }
PositionTable >> getSpaceshipsPositions [
    ^ spaceships collect: [ :aSpaceship | aSpaceship getPosition ].
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
