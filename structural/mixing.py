#!/usr/bin/env python3
"""Mixing lemma test (n=5): for every pair of tables T,T' in a fibre (no constant column), is there an
ordered pair of disjoint cherries P,Q with middle leaf m such that -C_m lies in mu_P(T) (+) mu_Q(T')?
(Then a table T'' with mu_P=mu_P(T), mu_Q=mu_Q(T') exists, so T and T' are 2 glued steps apart.)"""
import sys, itertools
from collections import Counter
sys.path.insert(0,'.')
from sumset import oplus
n=5; dlist=[int(x) for x in sys.argv[1].split(',')]
M=4
cher=list(itertools.combinations(range(5),2))
trip=[(P,Q,({0,1,2,3,4}-set(P)-set(Q)).pop()) for P in cher for Q in cher if not set(P)&set(Q)]
def cv(vals):
    c=[0]*4
    for v in vals: c[v%4]+=1
    return tuple(c)
def neg(v): return (v[0],v[3],v[2],v[1])
for d in dlist:
    ns={}; src=open('/home/user/proofs-archive/runs/z4/fibre_check.py').read().split('log=f"results')[0]
    sys.argv=['x',str(n),str(d)]; exec(src,ns); fibre=ns['fibre']; margins=ns['margins']
    fails=0; pairs=0; usage=Counter()
    for m in margins():
        if any(max(Counter(c).values())==d for c in m): continue
        F=fibre(m)
        if len(F)<2: continue
        Cm=[neg(cv(col)) for col in m]
        prof=[{P:cv([r[P[0]]+r[P[1]] for r in t]) for P in cher} for t in F]
        for i in range(len(F)):
            for j in range(len(F)):
                if i==j: continue
                pairs+=1; ok=False
                for P,Q,mm in trip:
                    if Cm[mm] in oplus(prof[i][P],prof[j][Q]): ok=True; usage[(len(set(P)|set(Q)),)]+=1; break
                if not ok:
                    fails+=1
                    if fails<=3: print("  fail:",m,F[i],F[j],flush=True)
    print(f"d={d}: ordered pairs {pairs}, no disjoint-cherry mix: {fails}",flush=True)
