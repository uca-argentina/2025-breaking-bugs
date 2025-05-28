Class {
	#name : 'AtomicBombTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AtomicBombTest >> testWhenSpaceshipLandsOnAtomicBombThenAllSpaceshipsGoTo1PositionAndLoseAShield [

	| aSpaceship aSpaceship2 aGameBuilder finishLine aGame aBoard aSpaceship3 |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.
	finishLine := 20.
	aBoard := Board withSize: finishLine andWormholeFrom: 8 to: 15.
	aBoard add: (AtomicBomb new) at: 4.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
					addSpaceship: aSpaceship3;
		         addBoard: aBoard;
		         addDice: (SequentialFixedDice onFaces: #(4 4 5));
		         build.
		
	aGame playRound.

	self assert: aSpaceship getPosition equals: 1.
	self assert: aSpaceship2 getPosition equals: 5.
	self assert: aSpaceship3 getPosition equals: 6.
	self assert: aSpaceship getShields equals:2.
	self assert: aSpaceship2 getShields equals:2.
	self assert: aSpaceship3 getShields equals:2
	
]
