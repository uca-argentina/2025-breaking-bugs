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
	opponent := spaceships
		            detect: [ :other |
			            other ~= aSpaceship and: [
				            other getPosition = aSpaceship getPosition ] ]
		            ifNone: [ nil ].

	opponent ifNotNil: [
		self resolveBattleBetween: aSpaceship and: opponent ]
]

{ #category : 'behavior' }
Battle >> getAllDiceValuesFrom: diceCollection [

	^ diceCollection
		  inject: 0
		  into: [ :sumOfValues :aDie | sumOfValues + aDie roll ]
]

{ #category : 'initialization' }
Battle >> getAllValuesIncludingMercenariesOf: aSpaceship [

	| spaceshipMercenaryDiceValue spaceShipDiceValue |
	spaceShipDiceValue := self getAllDiceValuesFrom: dice.
	aSpaceship numberOfMercenaries timesRepeat: [
		spaceshipMercenaryDiceValue := self getAllDiceValuesFrom: dice.
		spaceShipDiceValue := spaceshipMercenaryDiceValue max: spaceShipDiceValue ].
	^ spaceShipDiceValue
]

{ #category : 'initialization' }
Battle >> initializeWith: aCollectionOfSpacehips and: aCollectionOfDice [

	spaceships := aCollectionOfSpacehips.
	dice := aCollectionOfDice.
]

{ #category : 'behavior' }
Battle >> resolveBattleBetween: aSpaceship and: opponent [
	
	| loser spaceshipDiceValue oponentDiceValue |
	loser := aSpaceship.
	
	spaceshipDiceValue := self getAllValuesIncludingMercenariesOf: aSpaceship.
	oponentDiceValue := self getAllValuesIncludingMercenariesOf: opponent. 
	
	spaceshipDiceValue > oponentDiceValue ifTrue: [ loser :=  opponent].
	loser lowerAShield. 
	loser moveToPosition: 0.
	loser getMercenaries do: [:mercenary | mercenary lowerAShield ].
]
