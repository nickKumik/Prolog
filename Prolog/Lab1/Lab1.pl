byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(losAngeles,auckland).

travel(X, Y) :- byCar(X, Y).
travel(X, Y) :- byTrain(X, Y).
travel(X, Y) :- byPlane(X, Y).

travel(X,Y) :- byCar(X,Z), travel(Z,Y).
travel(X,Y) :- byTrain(X,Z), travel(Z,Y).
travel(X,Y) :- byPlane(X,Z), travel(Z,Y).

%%get rid of one trip repace with travel
onetrip(X,Y) :- byCar(X,Y);
                    byTrain(X,Y);
                    byPlane(X,Y).

travel(X,Y,go(X,Y)) :- onetrip(X,Y).

travel(X,Y,go(X,Z,Path)) :- onetrip(X,Z),
                            travel(Z,Y,Path).


directTrain(saarbruecken,dudweiler).
directTrain(forbach,saarbruecken).
directTrain(freyming,forbach).
directTrain(stAvold,freyming).
directTrain(fahlquemont,stAvold).
directTrain(metz,fahlquemont).
directTrain(nancy,metz).


directPath(X, Y) :-
    directTrain(X, Y).

directPath(X, Y) :-
    directTrain(Y, X),!.

%% base case
route(Y, Y, RevL, L) :-
    reverse(RevL, L).

%% inductive case
route(X, Y, RevL, L) :-
    directPath(X, Z),
    not(member(Z, RevL)),
    route(Z, Y, [Z | RevL], L).

%% main
route(X, Y, L) :-
    route(X, Y, [X], L).