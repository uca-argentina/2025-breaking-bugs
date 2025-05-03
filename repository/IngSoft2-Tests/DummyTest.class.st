Class {
	#name : 'DummyTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DummyTest >> testDummy [

	self deny: Dummy new isDummy
]

{ #category : 'tests' }
DummyTest >> testDummy2 [

	self deny: Dummy new isDummy
]
