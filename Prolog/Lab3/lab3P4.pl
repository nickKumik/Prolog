s(s(NP,VP)) --> np(NP, Num), vp(VP, Num).


np(np(DET,N), Num) --> det(DET, Num), n(N, Num).
np(np(DET,N,AP), Num) --> det(DET, Num), n(N, Num), ap(AP).

vp(vp(V), Num) --> iv(V, Num).
vp(vp(V, NP), Num) --> tv(V, Num), np(NP,_).

ap(ap(ADJ)) --> adj(ADJ).

det(det(Word),Num) --> [Word], {lex(Word,det,Num)}.

n(n(Word),Num) --> [Word], {lex(Word,n,Num)}.

tv(v(Word),Num) --> [Word], {lex(Word,v,Num,trans)}.

iv(v(Word),Num) --> [Word], {lex(Word,v,Num,intrans)}.
abj(adj(Word)) --> [Word], {lex(Word,adj)}.

lex(the, det,_).
lex(a, det,sg).
lex(two, det,pl).

lex(woman, n,sg).
lex(man, n,sg).
lex(women, n,pl).
lex(men, n,pl).

lex(hires, v,sg,trans).
lex(hire, v,pl,trans).

lex(falls, v,sg,intrans).
lex(fall, v,pl,intrans).
