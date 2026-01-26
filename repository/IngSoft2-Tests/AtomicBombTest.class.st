Class {
	#name : 'AtomicBombTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AtomicBombTest >> testWhenSpaceshipLandsOnAtomicBombThenAllSpaceshipsGoTo1PositionAndLoseAShield [

	| aSpaceship aSpaceship2 aGameBuilder finishLine aGame aBoard aSpaceship3 aTileBuilder aTileCollection |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	finishLine := 20.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder with: (AtomicBombEffect new) at: 4.
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
	self assert: (aGame getPositionOf: aSpaceship) equals: 0.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 5.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 6.
	
	self assert: (aGame getShieldsOf: aSpaceship) equals: 2.
	self assert: (aGame getShieldsOf: aSpaceship2) equals: 2.
	self assert: (aGame getShieldsOf: aSpaceship3) equals: 2.
	
]
