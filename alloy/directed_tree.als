/*
From Alloy HW 3
Problem 1: Directed Tree Properties
We give students the skeleton of isDirectedTree
and expect them to fill in the constraints.

TN: Changed to use Node sig rather than univ

BUG: mis-stated injectivity axiom. Manifests as:
	(1) unexpected co-existence of facts 
        caught by looking at an instance given
	(2) missing instances caught with 
        caught by test case pred that detects inconsistency      

	These do not manifest until we see 3 connected Nodes!
	(Minimality fails, but maximality will not.)
*/

sig Node {}

// Correct version:
pred isDirectedTreeCorrect (r: Node -> Node) {
	-- acyclic:
	no iden & ^r
	-- injective:
	r.~r in iden 
	-- connected:
	(Node -> Node) in ^(r + ~r)
} 

// Buggy version:
pred isDirectedTreeBug1 (r: Node -> Node) {
	-- acyclic:
	no iden & ^r
	-- injective:
	// BUG! Flipped transpose both under- and over-
	// constrains the problem. 
	~r.r in iden // [?] how are rel ops translated?
	//r.~r in iden // <- this is correct
	-- connected:
	(Node -> Node) in ^(r + ~r)
} 

// Partial model w/o partial model primitives:
// Find me an inst containing 3 nodes that form a < tree. 
// Expect SAT. If unsat, detect overconstraint.
pred testCaseForBug1 {
	some r: Node -> Node {
		isDirectedTreeBug1[r]
		//isDirectedTreeCorrect[r]
		some disj n1, n2, n3: Node | 
			n1->n2 + n1->n3 in r
		// [?] possible for this to be SAT but incorrectly?
		// If so, looking at instance would reveal another issue.
	}
}

pred isDirectedTreeBugMin {
	some r: Node -> Node |
	isDirectedTreeBug1[r] and
	(Node -> Node) in ^(r + ~r)
}

// Has two nodes with edges into the same node; non injective [Aluminum won't show]
run isDirectedTreeBug1 for 3 Node
// Unsat if using buggy pred. [Aluminum detects too]
run testCaseForBug1 for exactly 3 Node
run isDirectedTreeBugMin for exactly 3 Node 
