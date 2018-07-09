abstract sig Species {}
one sig Cat extends Species {}
one sig Dog extends Species {}

sig Animal { type: one Species }

fact { #{a : Animal | a.type=Cat}>#{a : Animal | a.type=Dog} }

run {} for exactly 3 Animal


/* 
INSTANCE
relations: {Int/next=[], seq/Int=[], String=[], this/Cat=[[Cat$0]], this/Dog=[[Dog$0]], this/Animal=[[Animal$0], [Animal$1], [Animal$2]], this/Animal.type=[[Animal$0, Dog$0], [Animal$1, Cat$0], [Animal$2, Cat$0]]}
ints: []

EXPLAIN: this/Animal.type={[Animal$2, Cat$0]}

EXPLAINATION CODES:
- TYPE : "has to be a cat or a dog because that's what the type hierarchy says"
- COUNT [depth]: "nth is a cat, because of some count on the nth-1 animal and the ... up to depth"

BOTTOM-UP EXPLANATIONS (exhaustive list, no depth limit, with codes):
--------------------------------------------------------------------
TYPE
(this/Animal.type[Animal$2, Cat$0])
	((this/Animal.type[Animal$2, Cat$0]|this/Animal.type[Animal$2, Dog$0]))
		((one (this . this/Animal.type) && ((this . this/Animal.type) in (this/Cat + this/Dog))){this=[[Animal$2]]})
			((all this: one this/Animal | (one (this . this/Animal.type) && ((this . this/Animal.type) in (this/Cat + this/Dog)))){})

--------------------------------------------------------------------
COUNT[1]->COUNT[2]
(this/Animal.type[Animal$2, Cat$0])
	(((a . this/Animal.type) = this/Cat){a=[[Animal$2]]})
		(((!this/Animal.type[Animal$2, Dog$0]&this/Animal.type[Animal$2, Cat$0])&<(!this/Animal.type[Animal$0, Dog$0]&this/Animal.type[Animal$0, Cat$0])?!(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0]):(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0])>))
			(<((!this/Animal.type[Animal$2, Dog$0]&this/Animal.type[Animal$2, Cat$0])&<(!this/Animal.type[Animal$0, Dog$0]&this/Animal.type[Animal$0, Cat$0])?!(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0]):(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0])>)?!((!this/Animal.type[Animal$0, Dog$0]&this/Animal.type[Animal$0, Cat$0])&(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0])):((!this/Animal.type[Animal$0, Dog$0]&this/Animal.type[Animal$0, Cat$0])&(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0]))>)

--------------------------------------------------------------------
COUNT[1]->TYPE
(this/Animal.type[Animal$2, Cat$0])
	(((a . this/Animal.type) = this/Cat){a=[[Animal$2]]})
		(<(!this/Animal.type[Animal$0, Dog$0]&this/Animal.type[Animal$0, Cat$0])?!(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0]):(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0])>)
			(((a . this/Animal.type) = this/Cat){a=[[Animal$1]]})
				(this/Animal.type[Animal$1, Cat$0])
					((this/Animal.type[Animal$1, Cat$0]|this/Animal.type[Animal$1, Dog$0]))
						((one (this . this/Animal.type) && ((this . this/Animal.type) in (this/Cat + this/Dog))){this=[[Animal$1]]})
							((all this: one this/Animal | (one (this . this/Animal.type) && ((this . this/Animal.type) in (this/Cat + this/Dog)))){})

--------------------------------------------------------------------
COUNT[1]->TYPE
(this/Animal.type[Animal$2, Cat$0])
	(((a . this/Animal.type) = this/Cat){a=[[Animal$2]]})
		(<(!this/Animal.type[Animal$0, Dog$0]&this/Animal.type[Animal$0, Cat$0])?!(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0]):(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0])>)
			(((a . this/Animal.type) = this/Cat){a=[[Animal$1]]})
				(this/Animal.type[Animal$1, Cat$0])
					((this/Animal.type[Animal$1, Cat$0]|this/Animal.type[Animal$1, Dog$0]))
						((one (this . this/Animal.type) && ((this . this/Animal.type) in (this/Cat + this/Dog))){this=[[Animal$1]]})
							((all this: one this/Animal | (one (this . this/Animal.type) && ((this . this/Animal.type) in (this/Cat + this/Dog)))){})

--------------------------------------------------------------------
COUNT[1]->COUNT[2]
(this/Animal.type[Animal$2, Cat$0])
	(((a . this/Animal.type) = this/Cat){a=[[Animal$2]]})
		(<(!this/Animal.type[Animal$0, Dog$0]&this/Animal.type[Animal$0, Cat$0])?!(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0]):(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0])>)
			(((!this/Animal.type[Animal$2, Dog$0]&this/Animal.type[Animal$2, Cat$0])&<(!this/Animal.type[Animal$0, Dog$0]&this/Animal.type[Animal$0, Cat$0])?!(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0]):(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0])>))
				(<((!this/Animal.type[Animal$2, Dog$0]&this/Animal.type[Animal$2, Cat$0])&<(!this/Animal.type[Animal$0, Dog$0]&this/Animal.type[Animal$0, Cat$0])?!(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0]):(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0])>)?!((!this/Animal.type[Animal$0, Dog$0]&this/Animal.type[Animal$0, Cat$0])&(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0])):((!this/Animal.type[Animal$0, Dog$0]&this/Animal.type[Animal$0, Cat$0])&(!this/Animal.type[Animal$1, Dog$0]&this/Animal.type[Animal$1, Cat$0]))>)

--------------------------------------------------------------------
*/ 
