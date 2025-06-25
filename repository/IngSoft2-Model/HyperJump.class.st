Class {
	#name : 'HyperJump',
	#superclass : 'Object',
	#instVars : [
		'currentIndex',
		'amountOfParcecsToAdvance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperJump class >> withDescendingLightYearsFrom: maxLightYears step: stepSize [

	| parsecList current currentInParcecs stepSizeInParcecs |
	current := maxLightYears.
	parsecList := OrderedCollection new.
	currentInParcecs := current // 3.
	stepSizeInParcecs := stepSize // 3.
	
	[ currentInParcecs > 0 ] whileTrue: [
		
		parsecList add: currentInParcecs.
		currentInParcecs := currentInParcecs - stepSizeInParcecs ].

	^ self new initializeWithParcecs: parsecList asArray
]

{ #category : 'as yet unclassified' }
HyperJump class >> withDescendingParsecsFrom: maxParsecs step: stepSize [

	| parsecList current |
	current := maxParsecs.
	parsecList := OrderedCollection new.

	[ current > 0 ] whileTrue: [
		parsecList add: current.
		current := current - stepSize ].

	^ self new initializeWithParcecs: parsecList asArray
]

{ #category : 'operations' }
HyperJump >> applyTo: aSpaceship in: aGame [

	| parsecsToAdvance newPosition sizeOfTileInParsecs |
	sizeOfTileInParsecs := 2.

	amountOfParcecsToAdvance size = currentIndex ifTrue: [
		currentIndex := 0 ].
	currentIndex := currentIndex + 1.

	parsecsToAdvance := amountOfParcecsToAdvance at: currentIndex.

	newPosition := aSpaceship getPosition
	               + (parsecsToAdvance // sizeOfTileInParsecs).
	aSpaceship moveToPosition: newPosition.

	aGame registerAppliedEffect: self
]

{ #category : 'initialization' }
HyperJump >> initializeWithParcecs: aParcecsArray [

	amountOfParcecsToAdvance := aParcecsArray.
	currentIndex := 0
]
