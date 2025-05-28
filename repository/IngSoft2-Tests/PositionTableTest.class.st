Class {
	#name : 'PositionTableTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
PositionTableTest >> compareValues: spaceshipsPositions with: expectedPositions [
    ^ spaceshipsPositions = expectedPositions
]

{ #category : 'asserting' }
PositionTableTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
PositionTableTest >> testCannotGetPositionTableBeforeGameIsFinished [

	| aGame aSpaceship aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 10);
		         build.

	aGame playRound.
	self
		should: [ aGame getPositionTable ]
		raise: Error
		withMessageText:
		'Cannot get position table before game ends.'
]

{ #category : 'tests' }
PositionTableTest >> testWhenGameEndsThenThePositionTableCanBeKnown [

	| aGame aSecondSpaceship aPositionTable expectedPositions aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSecondSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: Spaceship new;
					addSpaceship: aSecondSpaceship; 
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 20);
		         build.

	aGame playRound.
	aPositionTable := (aGame getPositionTable).

	expectedPositions := OrderedCollection newFrom: #( 20 0 ).
	self assert: (self compareValues: (aPositionTable getSpaceshipsPositions) with: expectedPositions)
]

{ #category : 'tests' }
PositionTableTest >> testWhenGameEndsThenTheRankingCanBeKnown [ 

	| aGame aSecondSpaceship  aGameBuilder aFirstSpaceship aThirdSpaceship expectedRanking aPosicionTable aRankingPosition aFourthSpaceship |
	aGameBuilder := GameBuilder new.
	aFirstSpaceship := Spaceship new.
	aSecondSpaceship := Spaceship new.
	aThirdSpaceship := Spaceship new.
	aFourthSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aFirstSpaceship;
					addSpaceship: aSecondSpaceship; 
					addSpaceship: aThirdSpaceship;
					addSpaceship: aFourthSpaceship ; 
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 15);
		         addDice: (SequentialFixedDice onFaces: #(20 4 12 6 20 6 5 1));
					setLapsToWinTo: 2;
		         build.

	aGame playRound.
	aGame playRound.
	aPosicionTable := (aGame getPositionTable ).
	
	aRankingPosition := aPosicionTable getRanking.
	expectedRanking := { aFirstSpaceship. aSecondSpaceship. aThirdSpaceship. aFourthSpaceship }.
	"nave 1: ganadora
	nave2: posicion 1 vueltas 1
	nave3: posicion 17 vueltas 0
	nave4: posicion 7 vueltas 0 "
	
	self assert: aRankingPosition size equals: expectedRanking size.
	
	1 to: aRankingPosition size do: [ :i |
		self assert: (aRankingPosition at: i) equals: (expectedRanking at: i) ].


	
]

{ #category : 'tests' }
PositionTableTest >> testWhenGameEndsThenTheWinnerCanBeKnown [

	| aGame aSpaceship aPositionTable aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: aSpaceship;
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 20);
		         build.

	aGame playRound.
	aPositionTable := (aGame getPositionTable).
	self assert: (aPositionTable isWinner: aSpaceship)
]

{ #category : 'tests' }
PositionTableTest >> testWhenGameEndsThenTheWinnerIsNotASpaceshipThatIsNotOnTheFinishLine [

	| aGame aSecondSpaceship aPositionTable aGameBuilder |
	aGameBuilder := GameBuilder new.
	aSecondSpaceship := Spaceship new.
	aGame := aGameBuilder
		         addSpaceship: Spaceship new;
					addSpaceship: aSecondSpaceship; 
		         addBoard: (Board withSize: 20 andWormholeFrom: 4 to: 9);
		         addDice: (FixedDice onFace: 20);
		         build.

	aGame playRound.
	aPositionTable := (aGame getPositionTable).
	self deny: (aPositionTable isWinner: aSecondSpaceship).
]
