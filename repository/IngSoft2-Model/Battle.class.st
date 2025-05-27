Class {
	#name : 'Battle',
	#superclass : 'Object',
	#instVars : [
		'spaceships',
		'dice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Battle class >> with: spaceships and: dice [ 
	^ self new initializeWith: spaceships and: dice.
]

{ #category : 'behavior' }
Battle >> checkForBattleIfNeededWith: aSpaceship [
	| opponent |
	opponent := spaceships detect: [ :other | other ~= aSpaceship and: [ other getPosition = aSpaceship getPosition ] ] ifNone: [ nil ].

	opponent ifNotNil: [
		self resolveBattleBetween: aSpaceship and: opponent  ].
]

{ #category : 'behavior' }
Battle >> getAllDiceValuesFrom: diceCollection [

	^ diceCollection
		  inject: 0
		  into: [ :sumOfValues :aDie | sumOfValues + aDie roll ]
]

{ #category : 'initialization' }
Battle >> initializeWith: aCollectionOfSpacehips and: aCollectionOfDice [

	spaceships := aCollectionOfSpacehips.
	dice := aCollectionOfDice.
]

{ #category : 'behavior' }
Battle >> resolveBattleBetween: aSpaceship and: opponent [
	
	| loser spaceShipDiceValue oponentDiceValue |
	loser := aSpaceship.
	spaceShipDiceValue := self getAllDiceValuesFrom: dice. 
	oponentDiceValue := self getAllDiceValuesFrom: dice. 
	spaceShipDiceValue > oponentDiceValue ifTrue: [ loser :=  opponent].
	loser lowerAShield. 
	loser moveToPosition: 0.
]
