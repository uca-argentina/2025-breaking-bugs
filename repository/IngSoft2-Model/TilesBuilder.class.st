Class {
	#name : 'TilesBuilder',
	#superclass : 'Object',
	#instVars : [
		'size',
		'aTileCollection',
		'numberOfPositionsToGoBack',
		'noEffectPercentage',
		'blackholePercentage',
		'hyperSpaceJumpPercentage',
		'moonwalkPercentage',
		'hyperJumpPercentage',
		'atomicBombPercentage',
		'cardTitlePercentage',
		'isInParcecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TilesBuilder class >> with: finishLine [
	^ self new initializeWith: finishLine andValuesInParcecs: true.
]

{ #category : 'instance creation' }
TilesBuilder class >> withInLightYears: finishLine [
	
	| finishLineInParcecs |
	finishLineInParcecs := finishLine // 3.
	^ self new initializeWith: finishLineInParcecs andValuesInParcecs: false.
]

{ #category : 'behavior' }
TilesBuilder >> build [

	^ aTileCollection
]

{ #category : 'behavior' }
TilesBuilder >> buildRandom [

	| weightedEffects effectsCollection |
weightedEffects := Dictionary new
	                   at: [ NoEffect new ] put: noEffectPercentage;
	                   at: [ BlackHole new ] put: blackholePercentage;
	                   at: [ HyperSpaceJump new ] put: hyperSpaceJumpPercentage;
	                   at: [ MoonWalk for: numberOfPositionsToGoBack ]
	                   put: moonwalkPercentage;
	                   at: [ HyperJump new ] put: hyperJumpPercentage;
	                   at: [ AtomicBomb new ] put: atomicBombPercentage;
							at: [ ObtainCard new ] put: cardTitlePercentage ;
	                   yourself.


effectsCollection := (1 to: size) collect: [ :i |
	                     Tile with: (weightedEffects keys
			                      atRandom: Random new
			                      weighting: [ :block |
			                      weightedEffects at: block ]) value ].

^ effectsCollection
]

{ #category : 'initialize' }
TilesBuilder >> initializeWith: aSize [

	size := aSize.
	numberOfPositionsToGoBack := 4.
	aTileCollection := (1 to: size+1) collect: [ :i |
		                   Tile with: NoEffect new ].
	noEffectPercentage := 40.
	blackholePercentage := 20.
	hyperSpaceJumpPercentage := 20.
	moonwalkPercentage := 10.
	hyperJumpPercentage := 8.
	atomicBombPercentage := 2.
	cardTitlePercentage := 0.
]

{ #category : 'initialize' }
TilesBuilder >> initializeWith: aSize andValuesInParcecs: ifInIsParcecs [
	size := aSize.
	isInParcecs := ifInIsParcecs .
	numberOfPositionsToGoBack := 4.
	aTileCollection := (1 to: size+1) collect: [ :i |
		                   Tile with: NoEffect new ].
	noEffectPercentage := 40.
	blackholePercentage := 20.
	hyperSpaceJumpPercentage := 20.
	moonwalkPercentage := 10.
	hyperJumpPercentage := 8.
	atomicBombPercentage := 2.
	cardTitlePercentage := 0.
]

{ #category : 'behavior' }
TilesBuilder >> setForMoonwalk: aNumberOfPositionsToGoBack [

	numberOfPositionsToGoBack := aNumberOfPositionsToGoBack
]

{ #category : 'behavior' }
TilesBuilder >> setRandomness: aCollectionOfPercentages [
	(aCollectionOfPercentages size = 7) ifFalse: [ Error signal: 'La colección debe tener 6 probabilidades' ].
	(aCollectionOfPercentages sum = 100) ifFalse: [ Error signal: 'Las probabilidades deben sumar 100' ].
	noEffectPercentage := aCollectionOfPercentages at: 1.
	blackholePercentage := aCollectionOfPercentages at: 2.
	hyperSpaceJumpPercentage := aCollectionOfPercentages at: 3.
	moonwalkPercentage := aCollectionOfPercentages at: 4.
	hyperJumpPercentage := aCollectionOfPercentages at: 5.
	atomicBombPercentage := aCollectionOfPercentages at: 6.
	cardTitlePercentage := aCollectionOfPercentages at: 7.
]

{ #category : 'behavior' }
TilesBuilder >> with: anEffect at: aPosition [

	| positionToSet |
	(isInParcecs )ifTrue: [positionToSet := aPosition ] ifFalse:[positionToSet :=aPosition //3 ] .

	aTileCollection at: positionToSet + 1 put: (Tile with: anEffect)
]
