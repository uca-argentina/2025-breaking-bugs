Class {
	#name : 'RandomCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
RandomCard class >> obtainCard [
	| cardClasses |
	cardClasses := { SpeedCard. MercenaryCard. AccelerationCard. CancelationCard. RedoCard. RepeatCard }.
	^ (cardClasses atRandom) new
]
