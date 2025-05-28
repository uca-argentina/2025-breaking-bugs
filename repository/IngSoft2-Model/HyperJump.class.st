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

{ #category : 'operations' }
HyperJump >> applyTo: aSpaceship in: aGame [

	| parsecsToAdvance newPosition |
	amountsOfParsecsToAdvance size = currentIndex ifTrue: [
		currentIndex := 0 ].
	currentIndex := currentIndex + 1.

	parsecsToAdvance := amountsOfParsecsToAdvance at: currentIndex.

	newPosition := aSpaceship getPosition + (parsecsToAdvance // 2).
	aSpaceship moveToPosition: newPosition
]

{ #category : 'initialization' }
HyperJump >> initialize [

	amountsOfParsecsToAdvance := { 10. 20. 30 }.
	currentIndex := 0
]
