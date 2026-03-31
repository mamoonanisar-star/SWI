# Family Tree (SWI-Prolog)

This repository contains a SWI-Prolog knowledge base for the family tree shown in the assignment diagram. Facts use only the predicates `wife/2`, `son/2`, and `daughter/2`; rules derive the remaining relationships.

## Usage

Load the knowledge base in SWI-Prolog (names are lowercase atoms):

```bash
swipl -q -l family.pl
```

Example queries from the assignment:

```prolog
?- husband(H, sarah).
H = andrew.

?- grandChild(G, elizabeth).
G = beatrice ;
G = eugenie ;
G = harry ;
G = peter ;
G = william ;
G = zara.

?- setof(GP, greatGrandParent(GP, zara), GPs).
GPs = [george, mum].

?- setof(S, sisterInLaw(S, diana), SistersInLaw).
SistersInLaw = [anne, sarah].

?- setof(U, uncle(U, beatrice), Uncles).
Uncles = [charles, edward, mark].
```

Press `;` to see additional solutions in the interactive examples where applicable.
