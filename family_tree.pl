/* ============================================================
   Question 4: Family Tree Knowledge Base in SWI-Prolog
   Interpretation: p(x,y) means "x is the p of y"

   Family tree (British Royal Family):

       George = Mum          Spencer = Kydd
            |                      |
     +------+------+               |
     |             |               |
  Elizabeth = Philip           Diana
     |
  +--+--------+--------+
  |           |        |
Charles=Diana Anne=Mark Andrew=Sarah  Edward
  |           |           |
 +--+       +---+       +---+
 |  |       |   |       |   |
Wm Harry  Peter Zara  Beatrice Eugenie

   Females: Mum, Kydd, Elizabeth, Margaret, Diana, Anne,
            Sarah, Zara, Beatrice, Eugenie
   ============================================================ */

/* ----------------------------------------------------------
   Part (a): Facts using only wife/2, son/2, daughter/2
   ---------------------------------------------------------- */

% wife(Wife, Husband)
wife(mum,       george).
wife(elizabeth, philip).
wife(kydd,      spencer).
wife(diana,     charles).
wife(anne,      mark).
wife(sarah,     andrew).

% son(Son, Parent)
son(charles, philip).
son(charles, elizabeth).
son(andrew,  philip).
son(andrew,  elizabeth).
son(edward,  philip).
son(edward,  elizabeth).
son(peter,   mark).
son(peter,   anne).
son(william, charles).
son(william, diana).
son(harry,   charles).
son(harry,   diana).

% daughter(Daughter, Parent)
daughter(elizabeth, george).
daughter(elizabeth, mum).
daughter(margaret,  george).
daughter(margaret,  mum).
daughter(anne,      philip).
daughter(anne,      elizabeth).
daughter(diana,     spencer).
daughter(diana,     kydd).
daughter(zara,      mark).
daughter(zara,      anne).
daughter(beatrice,  andrew).
daughter(beatrice,  sarah).
daughter(eugenie,   andrew).
daughter(eugenie,   sarah).

/* ----------------------------------------------------------
   Part (b): Inference rules
   ---------------------------------------------------------- */

% husband(X, Y): X is the husband of Y
husband(X, Y) :- wife(Y, X).

% spouse(X, Y): X is a spouse of Y
spouse(X, Y) :- wife(X, Y).
spouse(X, Y) :- husband(X, Y).

% child(X, Y): X is a child of Y
child(X, Y) :- son(X, Y).
child(X, Y) :- daughter(X, Y).

% parent(X, Y): X is a parent of Y
parent(X, Y) :- child(Y, X).

% grandChild(X, Y): X is a grandchild of Y
grandChild(X, Y) :- child(X, Z), child(Z, Y).

% greatGrandParent(X, Y): X is a great-grandparent of Y
greatGrandParent(X, Y) :- parent(X, Z), parent(Z, W), parent(W, Y).

% brother(X, Y): X is a brother of Y (X is male; X and Y share a parent)
brother(X, Y) :- son(X, P), child(Y, P), X \= Y.

% sister(X, Y): X is a sister of Y (X is female; X and Y share a parent)
sister(X, Y) :- daughter(X, P), child(Y, P), X \= Y.

% aunt(X, Y): X is an aunt of Y
% Case 1 – X is a sister of one of Y's parents
aunt(X, Y) :- parent(P, Y), sister(X, P).
% Case 2 – X is the wife of a brother of one of Y's parents
aunt(X, Y) :- parent(P, Y), brother(B, P), wife(X, B).

% uncle(X, Y): X is an uncle of Y
% Case 1 – X is a brother of one of Y's parents
uncle(X, Y) :- parent(P, Y), brother(X, P).
% Case 2 – X is the husband of a sister of one of Y's parents
uncle(X, Y) :- parent(P, Y), sister(S, P), husband(X, S).

% brotherInLaw(X, Y): X is a brother-in-law of Y
% Case 1 – X is a brother of Y's spouse
brotherInLaw(X, Y) :- spouse(S, Y), brother(X, S).
% Case 2 – X is the husband of Y's sister
brotherInLaw(X, Y) :- sister(Si, Y), husband(X, Si).
% Case 3 – X is the husband of Y's spouse's sister
brotherInLaw(X, Y) :- spouse(S, Y), sister(Si, S), husband(X, Si).

% sisterInLaw(X, Y): X is a sister-in-law of Y
% Case 1 – X is a sister of Y's spouse
sisterInLaw(X, Y) :- spouse(S, Y), sister(X, S).
% Case 2 – X is the wife of Y's brother
sisterInLaw(X, Y) :- brother(B, Y), wife(X, B).
% Case 3 – X is the wife of Y's spouse's brother
sisterInLaw(X, Y) :- spouse(S, Y), brother(B, S), wife(X, B).

% firstCousin(X, Y): X is a first cousin of Y
% (X's parent and Y's parent are siblings)
firstCousin(X, Y) :- parent(PX, X), parent(PY, Y), brother(PX, PY).
firstCousin(X, Y) :- parent(PX, X), parent(PY, Y), sister(PX, PY).

/* ----------------------------------------------------------
   Part (c): Test queries

   i)   Who is Sarah's husband?
        ?- husband(X, sarah).
        X = andrew.

   ii)  Who are Elizabeth's grandchildren?
        ?- grandChild(X, elizabeth).
        X = peter ; X = william ; X = harry ; X = zara ;
        X = beatrice ; X = eugenie ; ...

   iii) Who are Zara's great-grandparents?
        ?- greatGrandParent(X, zara).
        X = george ; X = mum ; ...

   iv)  Who are Diana's sisters-in-law?
        ?- sisterInLaw(X, diana).
        X = anne ; X = sarah ; ...

   v)   Who are Beatrice's uncles?
        ?- uncle(X, beatrice).
        X = charles ; X = edward ; X = mark ; ...
   ---------------------------------------------------------- */
