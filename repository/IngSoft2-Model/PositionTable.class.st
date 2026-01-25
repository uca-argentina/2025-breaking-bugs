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
PositionTable class >> with: spaceships [

	^ self new instanceWith: spaceships
]

{ #category : 'behavior' }
PositionTable >> getRanking [
    ^ spaceships asSortedCollection: [ :aSpaceship1 :aSpaceship2 | aSpaceship1 isAheadOf: aSpaceship2 ]
]

{ #category : 'initialization' }
PositionTable >> instanceWith: aCollectionOfSpaceships [

	spaceships := aCollectionOfSpaceships collect: [ :each | each copy ].
]

{ #category : 'behavior' }
PositionTable >> isShip: aSpaceship atLap: aLap andSquare: aSquare [
    | foundShip |
    foundShip := spaceships detect: [ :each | each = aSpaceship ] ifNone: [ ^ false ].
    ^ foundShip isAtLap: aLap andAtSquare: aSquare.
]

{ #category : 'behavior' }
PositionTable >> isWinner: aSpaceship [
    ^ self getRanking first = aSpaceship
]
