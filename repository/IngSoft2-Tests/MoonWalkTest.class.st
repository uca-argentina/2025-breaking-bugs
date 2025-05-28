Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MoonWalkTest >> testWhenSpaceshipLandsOnMoonwalkThenTheOtherSpaceshipsGoBack2Positions [

	| aSpaceship aSpaceship2 aGameBuilder finishLine aGame aBoard |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aSpaceship2 := Spaceship new.
	finishLine := 20.
	aBoard := Board withSize: finishLine andWormholeFrom: 5 to: 15.
	aBoard add: (MoonWalk for: 2) at: 4.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addSpaceship: aSpaceship2;
		         addBoard: aBoard;
		         addDice: (SequentialFixedDice onFaces: #( 4 4 ));
		         build.
	aGame playRound.

	self assert: aSpaceship getPosition equals: 4.
	self assert: aSpaceship2 getPosition equals: 2
]
