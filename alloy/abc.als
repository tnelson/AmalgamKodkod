abstract sig Person {
  supervises: set Person,
  grad: one School
}
one sig Alice extends Person {}{ 
supervises = Bob
grad = Brown
}
one sig Bob extends Person {}{ supervises = Charlie }
one sig Charlie extends Person {}{ 
no supervises
grad = NotBrown
}

abstract sig School {}
one sig Brown extends School {}
one sig NotBrown extends School {}

run { 
some bg : grad.Brown | 
some nbg : grad.NotBrown |
nbg in bg.supervises
}


