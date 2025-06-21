Class {
	#name : 'TitleBuilderTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
TitleBuilderTest >> testIsValidIfTileEffectDistributionMatchesExpectedProbabilities [

	| finishLine aTileBuilder aTileCollection percentages tolerance countsOfTitles |
	finishLine := 10000. 
	aTileBuilder := TilesBuilder with: finishLine.
	aTileCollection := aTileBuilder buildRandom.

	countsOfTitles := OrderedCollection new.
	countsOfTitles add: (aTileCollection count: [:tile | tile hasThisEffect: NoEffect ]).
	countsOfTitles add: (aTileCollection count: [:tile | tile hasThisEffect: BlackHole ]).
	
	countsOfTitles add: (aTileCollection count: [:tile | tile hasThisEffect: HyperSpaceJump ]).
	countsOfTitles add: (aTileCollection count: [:tile | tile hasThisEffect: MoonWalk ]).
	countsOfTitles add: (aTileCollection count: [:tile | tile hasThisEffect: HyperJump ]).
	countsOfTitles add: ( aTileCollection count: [:tile | tile hasThisEffect: AtomicBomb ]).
	"HyperSpaceJump 20 MoonWalk 10 HyperJump 8 AtomicBomb 2"
	percentages := countsOfTitles collect: [ :count | (count asFloat / finishLine) * 100 ].

	tolerance := 0.

	self assert: ((percentages at: 1) between: (39-tolerance) and: (41+tolerance)).
	self assert: ((percentages at: 2) between: (19-tolerance) and: (21+tolerance)).
	self assert: ((percentages at: 3) between: (19-tolerance) and: (21+tolerance)).
	self assert: ((percentages at: 4) between: (9-tolerance) and: (11+tolerance)).
	self assert: ((percentages at: 5) between: (7-tolerance) and: (9+tolerance)).
	self assert: ((percentages at: 6) between: (1-tolerance) and: (3+tolerance)).

]

{ #category : 'tests' }
TitleBuilderTest >> testTileEffectDistributionMatchesExpectedProbabilitiesWithCardTitle [

	| finishLine aTileBuilder aTileCollection percentages tolerance countsOfTitles |
	finishLine := 10000. 
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder setRandomness: #(35 19 19 9 7 2 9).
	aTileCollection := aTileBuilder buildRandom.

	countsOfTitles := OrderedCollection new.
	countsOfTitles add: (aTileCollection count: [:tile | tile hasThisEffect: NoEffect ]).
	countsOfTitles add: (aTileCollection count: [:tile | tile hasThisEffect: BlackHole ]).
	
	countsOfTitles add: (aTileCollection count: [:tile | tile hasThisEffect: HyperSpaceJump ]).
	countsOfTitles add: (aTileCollection count: [:tile | tile hasThisEffect: MoonWalk ]).
	countsOfTitles add: (aTileCollection count: [:tile | tile hasThisEffect: HyperJump ]).
	countsOfTitles add: ( aTileCollection count: [:tile | tile hasThisEffect: AtomicBomb ]).
	countsOfTitles add: ( aTileCollection count: [:tile | tile hasThisEffect: ObtainCard ]).
	
	percentages := countsOfTitles collect: [ :count | (count asFloat / finishLine) * 100 ].

	tolerance := 0.

	self assert: ((percentages at: 1) between: (34-tolerance) and: (37+tolerance)).
	self assert: ((percentages at: 2) between: (18-tolerance) and: (20+tolerance)).
	self assert: ((percentages at: 3) between: (18-tolerance) and: (20+tolerance)).
	self assert: ((percentages at: 4) between: (8-tolerance) and: (10+tolerance)).
	self assert: ((percentages at: 5) between: (6-tolerance) and: (8+tolerance)).
	self assert: ((percentages at: 6) between: (1-tolerance) and: (3+tolerance)).
	self assert: ((percentages at: 7) between: (8-tolerance) and: (10+tolerance)).

]
