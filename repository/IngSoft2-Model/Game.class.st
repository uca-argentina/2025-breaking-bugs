Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'theGameHasFinished',
		'players',
		'board',
		'dices'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
Game class >> create [
	^ (self new) instance.
]

{ #category : 'as yet unclassified' }
Game class >> withBoard: aBoard [ 
	^ (self new) instanceWithBoard: aBoard.
]

{ #category : 'adding' }
Game >> addDice: aDice [ 
	dices add: aDice.
]

{ #category : 'adding' }
Game >> addPlayer: aSpaceship [ 
  players add: aSpaceship.
]

{ #category : 'testing' }
Game >> checkPositionOfPlayers: aPosition [
    ^ players anySatisfy: [ :aSpaceship | aSpaceship isAtPosition: aPosition ].
]

{ #category : 'initialization' }
Game >> finish [
	^ theGameHasFinished.
]

{ #category : 'testing' }
Game >> hasABoard [
	^ board notNil.
]

{ #category : 'testing' }
Game >> hasDices [

	^ dices notEmpty
]

{ #category : 'testing' }
Game >> hasPlayers [
	^ players notEmpty.
]

{ #category : 'accessing' }
Game >> instance [
	theGameHasFinished := false.
	players := OrderedCollection new.
]

{ #category : 'initialization' }
Game >> instanceWithBoard: aBoard [ 
	theGameHasFinished := false.
	players := OrderedCollection new.
	board := aBoard.
	dices := OrderedCollection new.
]

{ #category : 'roll' }
Game >> rollDices [
    players do: [ :aPlayer | aPlayer move ].
	 board moveIfWormhole: players.
]
