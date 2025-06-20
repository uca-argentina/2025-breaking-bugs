Class {
	#name : 'MercenaryCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
MercenaryCard >> implementEfectBy: aSpaceship on: aTargetSpaceship [

	"aTargetSpaceship ifNil: [
			Error signal:
				'No other spaceship is available to be assigned as a mercenary.' ]."
	aTargetSpaceship ifNil: [ ^ nil ].
	aTargetSpaceship makeSpaceshipOwnedBy: aSpaceship.
	aSpaceship makeHimOwnerOf: aTargetSpaceship
]
