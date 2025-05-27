Class {
	#name : 'CircularBoard',
	#superclass : 'Object',
	#instVars : [
		'board',
		'size'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CircularBoard class >> withSize: aSize andWormholeFrom: wormholeEntry to: wormholeExit [

	Board validateWith: wormholeEntry and: wormholeExit within: aSize.

	^ self new
		  intializeWithSize: aSize
		  andWormholeFrom: wormholeEntry
		  to: wormholeExit
]

{ #category : 'testing' }
CircularBoard >> checkIfSpaceshipWon: aSpaceshipPosition [ 
	^ false.
]

{ #category : 'testing' }
CircularBoard >> correctPositionAfterWormholeIfNeeded: aSpaceshipPosition [
	
	^ board correctPositionAfterWormholeIfNeeded: aSpaceshipPosition.
]

{ #category : 'testing' }
CircularBoard >> correctPositionIf: aSpaceship passTheLine: aSpaceshipPosition [
    | lapsCompleted newPosition |
    lapsCompleted := aSpaceshipPosition // size.
    newPosition := aSpaceshipPosition \\ size.
    aSpaceship incrementLapsBy: lapsCompleted.
    ^ newPosition = 0 ifTrue: [size] ifFalse: [newPosition].

]

{ #category : 'behavior' }
CircularBoard >> getAllDiceValuesFrom: diceCollection [

	^ diceCollection
		  inject: 0
		  into: [ :sumOfValues :aDie | sumOfValues + aDie roll ]
]

{ #category : 'initialization' }
CircularBoard >> intializeWithSize: aSize andWormholeFrom: aWormholeEntry to: aWormholeExit [
	size := aSize.
	board := Board withSize: size andWormholeFrom: aWormholeEntry to: aWormholeExit.
]

{ #category : 'behavior' }
CircularBoard >> resolveBattleBetween: aSpaceship and: opponent with: dice [ 
	
	| loser spaceShipDiceValue oponentDiceValue |
	loser := opponent.
	spaceShipDiceValue := self getAllDiceValuesFrom: dice. 
	oponentDiceValue := self getAllDiceValuesFrom: dice. 
	spaceShipDiceValue > oponentDiceValue ifTrue: [ loser :=  aSpaceship].
	loser lowerAShield. 
	loser moveToPosition: 0.
]
