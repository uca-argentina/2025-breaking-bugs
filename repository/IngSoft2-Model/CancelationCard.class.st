Class {
	#name : 'CancelationCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
CancelationCard >> = anotherCard [

^ (anotherCard compareID: id).

]

{ #category : 'comparing' }
CancelationCard >> compareID: anId [ 
	^ id = anId.
]

{ #category : 'behavior' }
CancelationCard >> implementEffect: aPermanentCard by: aSpaceship to: aTargetSpaceship in: aGame [

	aPermanentCard undoEffect: aGame to: aTargetSpaceship.
	aGame registerThrownCard: self.
]

{ #category : 'initialization' }
CancelationCard >> initialize [
id := 'CancelationCard-' , (0 to: 9999) atRandom asString.
]
