Class {
	#name : 'GameBuilder',
	#superclass : 'Object',
	#instVars : [
		'spaceships',
		'aBoard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
GameBuilder >> addBoard: board [

	aBoard := board
]

{ #category : 'adding' }
GameBuilder >> addSpaceship: aSpaceship [

	spaceships add: aSpaceship
]

{ #category : 'building' }
GameBuilder >> build [

	self verifyABoardHasBeenAdded.
	self verifyAtLeastOneSpaceshipHasBeenAdded.

	^ Game with: aBoard and: spaceships
]

{ #category : 'initialization' }
GameBuilder >> initialize [

	spaceships := OrderedCollection new
]

{ #category : 'building' }
GameBuilder >> verifyABoardHasBeenAdded [

	aBoard ifNil: [ Error signal: 'Cannot build a game without a board' ]
]

{ #category : 'building' }
GameBuilder >> verifyAtLeastOneSpaceshipHasBeenAdded [

	spaceships isEmpty ifTrue: [
		Error signal: 'Cannot build a game without spaceships' ]
]
