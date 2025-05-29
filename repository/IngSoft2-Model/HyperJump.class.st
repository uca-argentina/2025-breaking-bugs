Class {
	#name : 'HyperJump',
	#superclass : 'Object',
	#instVars : [
		'amountsOfParsecsToAdvance',
		'currentIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperJump class >> withDescendingParsecsFrom: maxParsecs step: stepSize [

	| parsecList current |
	current := maxParsecs.
	parsecList := OrderedCollection new.

	[ current > 0 ] whileTrue: [
		parsecList add: current.
		current := current - stepSize ].

	^ self new initializeWithParsecs: parsecList asArray
]

{ #category : 'operations' }
HyperJump >> applyTo: aSpaceship in: aGame [

	| parsecsToAdvance newPosition sizeOfTileInParsecs |
	sizeOfTileInParsecs := 2.

	amountsOfParsecsToAdvance size = currentIndex ifTrue: [
		currentIndex := 0 ].
	currentIndex := currentIndex + 1.

	parsecsToAdvance := amountsOfParsecsToAdvance at: currentIndex.

	newPosition := aSpaceship getPosition
	               + (parsecsToAdvance // sizeOfTileInParsecs).
	aSpaceship moveToPosition: newPosition
]

{ #category : 'initialization' }
HyperJump >> initializeWithParsecs: aParsecsArray [

	amountsOfParsecsToAdvance := aParsecsArray.
	currentIndex := 0
]
