% Facts from the family tree (Figure 1) using only wife/2, son/2, and daughter/2.
wife(mum, george).
wife(kydd, spencer).
wife(elizabeth, philip).
wife(diana, charles).
wife(anne, mark).
wife(sarah, andrew).

daughter(elizabeth, george).
daughter(elizabeth, mum).
daughter(margaret, george).
daughter(margaret, mum).
daughter(diana, spencer).
daughter(diana, kydd).
daughter(anne, philip).
daughter(anne, elizabeth).
daughter(zara, anne).
daughter(zara, mark).
daughter(beatrice, andrew).
daughter(beatrice, sarah).
daughter(eugenie, andrew).
daughter(eugenie, sarah).

son(charles, philip).
son(charles, elizabeth).
son(andrew, philip).
son(andrew, elizabeth).
son(edward, philip).
son(edward, elizabeth).
son(william, charles).
son(william, diana).
son(harry, charles).
son(harry, diana).
son(peter, anne).
son(peter, mark).

% Derived gender helpers.
female(X) :- wife(X, _).
female(X) :- daughter(X, _).
male(X) :- husband(X, _).
male(X) :- son(X, _).

% Core family relations.
husband(H, W) :- wife(W, H).
spouse(X, Y) :- wife(X, Y).
spouse(X, Y) :- husband(X, Y).

child(C, P) :- son(C, P).
child(C, P) :- daughter(C, P).

parent(P, C) :- child(C, P).

grandChild(GC, GP) :-
    parent(GP, P),
    parent(P, GC).

greatGrandParent(GGP, GC) :-
    parent(GGP, GP),
    parent(GP, P),
    parent(P, GC).

sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

brother(B, X) :-
    male(B),
    sibling(B, X).

sister(S, X) :-
    female(S),
    sibling(S, X).

aunt(A, N) :-
    female(A),
    parent(P, N),
    sibling(A, P).
aunt(A, N) :-
    wife(A, U),
    parent(P, N),
    sibling(U, P).

uncle(U, N) :-
    male(U),
    parent(P, N),
    sibling(U, P).
uncle(U, N) :-
    husband(U, A),
    parent(P, N),
    sibling(A, P).

brotherInLaw(B, X) :-
    spouse(X, S),
    brother(B, S).
brotherInLaw(B, X) :-
    spouse(X, S),
    sibling(Sib, S),
    husband(B, Sib).
brotherInLaw(B, X) :-
    sibling(S, X),
    husband(B, S).

sisterInLaw(SL, X) :-
    spouse(X, S),
    sister(SL, S).
sisterInLaw(SL, X) :-
    spouse(X, S),
    sibling(Sib, S),
    wife(SL, Sib).
sisterInLaw(SL, X) :-
    sibling(S, X),
    wife(SL, S).

firstCousin(C1, C2) :-
    parent(P1, C1),
    parent(P2, C2),
    sibling(P1, P2),
    C1 \= C2.
