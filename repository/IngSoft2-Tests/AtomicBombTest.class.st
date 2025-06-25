Class {
	#name : 'AtomicBombTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AtomicBombTest >> testWhenSpaceshipLandsOnAtomicBombThenAllSpaceshipsGoTo1PositionAndLoseAShield [

	| aSpaceship aSpaceship2 aGameBuilder finishLine aGame aBoard aSpaceship3 aTileBuilder aTileCollection getter |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	finishLine := 20.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder with: (AtomicBomb new) at: 4.
	aTileCollection := aTileBuilder build.
	aBoard := Board withSize: finishLine andWormholeFrom: 8 to: 15 and: aTileCollection.

	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
					addSpaceship: aSpaceship3;
		         addBoard: aBoard;
		         addDice: (SequentialFixedDice onFaces: #(4 5 6));
		         build.
		
	aGame playRound.
	getter := aGame getObjectGetter.
	self assert: (getter getPositionOf: aSpaceship) equals: 0.
	self assert: (getter getPositionOf: aSpaceship2) equals: 5.
	self assert: (getter getPositionOf: aSpaceship3) equals: 6.
	
	self assert: (getter getShieldsOf: aSpaceship) equals: 2.
	self assert: (getter getShieldsOf: aSpaceship2) equals: 2.
	self assert: (getter getShieldsOf: aSpaceship3) equals: 2.
	
]
