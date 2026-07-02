Class {
	#name : 'RepeatCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RepeatCardTest >> testWhenUsingARepeatCardAfterABlackHoleEffectBeingAppliedThenItIsReapplied [

	| aSpaceship aGameBuilder finishLine aGame aBoard aTileCollection aTileBuilder aRepeatCard |
	aGameBuilder := GameBuilder new.
	aRepeatCard := RepeatCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: aRepeatCard).

	finishLine := 90.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileBuilder with: BlackHole new at: 4.
	aTileCollection := aTileBuilder build.
	aBoard := Board
		          withSize: finishLine
		          andWormholeFrom: 80
		          to: 89
		          and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: aBoard;
		         addDice: (SequentialFixedDice onFaces: { 4. 5 });
		         build.

	aGame playRound.
	aGame playRound.
	aGame playInstant: aRepeatCard of: aSpaceship to: aSpaceship.

	self assert: (aGame getPositionOf: aSpaceship) equals: 1
]

{ #category : 'tests' }
RepeatCardTest >> testWhenUsingARepeatCardAfterAHyperJumpEffectBeingAppliedThenItIsReapplied [

	| aSpaceship1 aSpaceship2 aSpaceship3 aGameBuilder finishLine aGame aBoard aTileCollection aTileBuilder aRepeatCard |
	aGameBuilder := GameBuilder new.
	aRepeatCard := RepeatCard new.
	aSpaceship1 := Spaceship with: (OrderedCollection with: aRepeatCard).
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.

	finishLine := 90.
	aTileBuilder := (TilesBuilder with: finishLine)
		                with:
		                (HyperJump withDescendingParsecsFrom: 30 step: 10)
		                at: 4.
	aTileCollection := aTileBuilder build.
	aBoard := Board
		          withSize: finishLine
		          andWormholeFrom: 80
		          to: 89
		          and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship1;
		         addSpaceship: aSpaceship2;
		         addSpaceship: aSpaceship3;
		         addBoard: aBoard;
		         addDice: (FixedDice onFace: 4);
		         build.

	aGame playRound.
	self assert: (aGame getPositionOf: aSpaceship1) equals: 19.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 14.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 9.

	aGame playInstant: aRepeatCard of: aSpaceship1 to: aSpaceship2.

	self assert: (aGame getPositionOf: aSpaceship1) equals: 19.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 29.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 9
]

{ #category : 'tests' }
RepeatCardTest >> testWhenUsingARepeatCardAfterAHyperSpaceJumpBeingAppliedThenItIsReapplied [

	| aSpaceship aGameBuilder finishLine aGame aBoard aTileCollection aTileBuilder aRepeatCard |
	aGameBuilder := GameBuilder new.
	aRepeatCard := RepeatCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: aRepeatCard).

	finishLine := 90.
	aTileBuilder := (TilesBuilder with: finishLine)
		                with: HyperSpaceJump new
		                at: 4.
	aTileCollection := aTileBuilder build.
	aBoard := Board
		          withSize: finishLine
		          andWormholeFrom: 80
		          to: 89
		          and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: aBoard;
		         addDice: (FixedDice onFace: 4);
		         build.

	aGame playRound.
	aGame playInstant: aRepeatCard of: aSpaceship to: aSpaceship.

	self assert: (aGame getPositionOf: aSpaceship) equals: 12.
	self assert: (aGame getShieldsOf: aSpaceship) equals: 1
]

{ #category : 'tests' }
RepeatCardTest >> testWhenUsingARepeatCardAfterAMoonWalkEffectBeingAppliedThenItIsReapplied [

	| aSpaceship1 aSpaceship2 aSpaceship3 aGameBuilder finishLine aGame aBoard aTileCollection aTileBuilder aRepeatCard |
	aGameBuilder := GameBuilder new.
	aRepeatCard := RepeatCard new.
	aSpaceship1 := Spaceship with: (OrderedCollection with: aRepeatCard).
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.

	finishLine := 90.
	aTileBuilder := (TilesBuilder with: finishLine)
		                with: (MoonWalk for: 3)
		                at: 9.
	aTileCollection := aTileBuilder build.
	aBoard := Board
		          withSize: finishLine
		          andWormholeFrom: 80
		          to: 89
		          and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship1;
		         addSpaceship: aSpaceship2;
		         addSpaceship: aSpaceship3;
		         addBoard: aBoard;
		         addDice: (SequentialFixedDice onFaces: { 7. 8. 9 });
		         build.

	aGame playRound.
	self assert: (aGame getPositionOf: aSpaceship1) equals: 4.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 5.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 9.

	aGame playInstant: aRepeatCard of: aSpaceship1 to: aSpaceship3.

	self assert: (aGame getPositionOf: aSpaceship1) equals: 1.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 2.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 9
]

{ #category : 'tests' }
RepeatCardTest >> testWhenUsingARepeatCardAfterAnAtomicBombEffectBeingAppliedThenItIsReapplied [

	| aSpaceship1 aSpaceship2 aSpaceship3 aGameBuilder finishLine aGame aBoard aTileCollection aTileBuilder aRepeatCard |
	aGameBuilder := GameBuilder new.
	aRepeatCard := RepeatCard new.
	aSpaceship1 := Spaceship with: (OrderedCollection with: aRepeatCard).
	aSpaceship2 := Spaceship new.
	aSpaceship3 := Spaceship new.

	finishLine := 90.
	aTileBuilder := (TilesBuilder with: finishLine)
		                with: AtomicBomb new
		                at: 6.
	aTileCollection := aTileBuilder build.
	aBoard := Board
		          withSize: finishLine
		          andWormholeFrom: 80
		          to: 89
		          and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship1;
		         addSpaceship: aSpaceship2;
		         addSpaceship: aSpaceship3;
		         addBoard: aBoard;
		         addDice:
			         (SequentialFixedDice onFaces: { 4. 5. 6. 7. 8. 9 });
		         build.

	aGame playRound.
	aGame playRound.
	self assert: (aGame getPositionOf: aSpaceship1) equals: 7.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 8.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 9.
	aGame playInstant: aRepeatCard of: aSpaceship1 to: aSpaceship2.

	self assert: (aGame getPositionOf: aSpaceship1) equals: 0.
	self assert: (aGame getPositionOf: aSpaceship2) equals: 0.
	self assert: (aGame getPositionOf: aSpaceship3) equals: 0.
	self assert: (aGame getShieldsOf: aSpaceship1) equals: 1.
	self assert: (aGame getShieldsOf: aSpaceship2) equals: 1.
	self assert: (aGame getShieldsOf: aSpaceship3) equals: 1
]

{ #category : 'tests' }
RepeatCardTest >> testWhenUsingARepeatCardHavingNotHavingAppliedAnEffectThenNothingHappens [

	| aSpaceship aGameBuilder finishLine aGame aBoard aTileCollection aTileBuilder aRepeatCard |
	aGameBuilder := GameBuilder new.
	aRepeatCard := RepeatCard new.
	aSpaceship := Spaceship with: (OrderedCollection with: aRepeatCard).

	finishLine := 90.
	aTileBuilder := TilesBuilder with: finishLine.
	aTileCollection := aTileBuilder build.
	aBoard := Board
		          withSize: finishLine
		          andWormholeFrom: 80
		          to: 89
		          and: aTileCollection.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: aBoard;
		         addDice: (FixedDice onFace: 4);
		         build.

	aGame playRound.
	aGame playInstant: aRepeatCard of: aSpaceship to: aSpaceship.

	self assert: (aGame getPositionOf: aSpaceship) equals: 4
]
