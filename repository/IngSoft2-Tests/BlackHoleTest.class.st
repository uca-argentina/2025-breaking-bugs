Class {
	#name : 'BlackHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BlackHoleTest >> testWhenSpaceshipLandsOnBlackHoleThenItIsMovedBack4Positions [

	| aSpaceship aGameBuilder finishLine aGame aCircularBoard|
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	finishLine := 19.
	aCircularBoard := (CircularBoard withSize: finishLine andWormholeFrom: 5 to: 15).
	aCircularBoard add: BlackHole new at: 4.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
			      addBoard: aCircularBoard;   
		         addDice: (FixedDice onFace: 4);
		         build.
	aGame playRound.
	
	self assert: (aSpaceship isAtPosition: 0)

]
