Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'theGameHasFinished',
		'players',
		'board'
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
Game >> add: aSpaceship [ 
  players add: aSpaceship.
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
]
