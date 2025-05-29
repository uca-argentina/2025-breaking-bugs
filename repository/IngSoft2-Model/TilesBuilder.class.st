Class {
	#name : 'TilesBuilder',
	#superclass : 'Object',
	#instVars : [
		'size',
		'aTileCollection',
		'numberOfPositionsToGoBack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TilesBuilder class >> with: finishLine [
	^ self new initializeWith: finishLine.
]

{ #category : 'behavior' }
TilesBuilder >> build [
 ^ aTileCollection 
]

{ #category : 'behavior' }
TilesBuilder >> buildRandom [
	| rng weightedEffects effectsCollection |
	rng := Random new.

	"Definir los efectos y su peso"
	weightedEffects := {
		[NoEffect new]                                   -> 40.
		[BlackHole new]                                  -> 20.
		[HyperSpaceJump new]                             -> 20.
		[MoonWalk for: numberOfPositionsToGoBack]       -> 10.
		[HyperJump new]                                -> 8.
		[AtomicBomb new]                                 -> 2.
	}.

	"Aleatoriamente crear una colección de tiles según la distribución"
	effectsCollection := (1 to: size) collect: [ :i |
		Tile with: (
			(weightedEffects keys) atRandom: rng weighting: [ :block | 
				weightedEffects at: block
			]) value
	].

	^ effectsCollection

]

{ #category : 'initialize' }
TilesBuilder >> initializeWith: aSize [
	size := aSize.
	numberOfPositionsToGoBack := 4.
	aTileCollection := (1 to: size) collect: [ :i | Tile with: NoEffect new ].
]

{ #category : 'behavior' }
TilesBuilder >> setForMoonwalk: aNumberOfPositionsToGoBack [
	numberOfPositionsToGoBack := aNumberOfPositionsToGoBack. 
]

{ #category : 'behavior' }
TilesBuilder >> with: anEffect at: aPosition [
	aTileCollection at: (aPosition + 1) put: (Tile with: anEffect).
]
