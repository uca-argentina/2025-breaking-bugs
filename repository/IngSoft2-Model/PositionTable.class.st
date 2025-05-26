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
